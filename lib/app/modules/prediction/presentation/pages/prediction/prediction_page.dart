import 'dart:io';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:eden/app/modules/prediction/domain/usecases/save_prediction.dart';
import 'package:eden/app/modules/prediction/domain/usecases/upload_file.dart';
import 'package:eden/app/modules/prediction/presentation/pages/prediction/prediction_controller.dart';
import 'package:eden/app/modules/prediction/presentation/pages/preview/preview_page.dart';
import 'package:eden/app/modules/prediction/presentation/states/prediction_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/prediction_entity.dart';
import '../../../domain/usecases/save_prediction.dart';
import '../../../domain/usecases/upload_file.dart';
import '../../states/prediction_state.dart';
import '../preview/preview_page.dart';
import 'prediction_controller.dart';

class PredictionPage extends StatefulWidget {
  final String uid;
  final PickedFile image;
  
  PredictionPage({@required this.uid, @required this.image});
  
  @override
  _PredictionPageState createState() => _PredictionPageState(uid);
}

class _PredictionPageState extends ModularState<PredictionPage, PredictionController> {
  final String uid;
  SavePrediction savePredictionUseCase;
  UploadFile uploadFileUseCase;
  PredictionEntity newPrediction = new PredictionEntity();

  _PredictionPageState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Observer(builder: (_) {
              var state = controller.state;
              if(state is StartState) {
                return FutureBuilder(
                  future: controller.prediction(widget.image),
                  builder: (ctx, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator()
                      );
                    }
                    return controller.setState(SuccessState(snapshot.data()));
                  },
                );
              } else if(state is SuccessState) {
                File file = File(widget.image.path);
                String id = UniqueKey().toString();
                return FutureBuilder(
                  future: controller.uploadFileUseCase(file, "predictionFiles", id, ""),
                  builder: (ctx, snapshot) {
                    if(!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      newPrediction = PredictionEntity(
                        imageUrl: snapshot.data.toString(),
                        predicted: state.list[0]['label'],
                        confidence: state.list[0]['confidence']
                      );
                      return FutureBuilder(
                        future: controller.savePrediction(newPrediction),
                        builder: (ctx, snapshot) {
                          if(!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return FutureBuilder(
                              future: controller.getPredictionById(snapshot.data.id),
                              builder: (ctx, snapshot) {
                                if(!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return PreviewPage(uid: widget.uid, snapshot: snapshot.data);
                                }
                              },
                            );
                          }
                        },
                      );
                    }
                  },
                );
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
    );
  }
}