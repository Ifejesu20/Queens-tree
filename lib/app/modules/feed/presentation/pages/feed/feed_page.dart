import 'dart:async';
import 'package:eden/app/modules/feed/presentation/pages/feed/feed_controller.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:eden/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:asuka/asuka.dart' as asuka;

class FeedPage extends StatefulWidget {
  final String uid;

  FeedPage({@required this.uid});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ModularState<FeedPage, FeedController> {
  ImageSource source;

  @override
  void initState() {
    super.initState();
    source = null;
    controller.getList(widget.uid);
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  Widget _appBar(BuildContext context) {
    return new AppBar(
      title: Text("My garden"),
      leading: new IconButton(
        icon: new Icon(Icons.logout),
        onPressed: () => {
          controller.signOut().then((_) {
            Modular.to.pushNamed("/login");
            asuka.showSnackBar(SnackBar(content: Text("Successfully signed out!")));
          }).catchError((err) {
            print(err);
          })
        }
      ),
    );
  }

  Future<bool> _showSelectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("From where do you want to take the photo?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    setState(() {
                      source = ImageSource.gallery;
                    });
                    Navigator.pop(context, true);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    setState(() {
                      source = ImageSource.camera;
                    });
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: _appBar(context),
        body: Observer(builder: (_) {
          if(controller.predictionList.hasError || controller.predictionList.data == null) {
            return Container();
          } else {
            List<PredictionEntity> list = controller.predictionList.data;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                var model = list[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Ink.image(
                        image: NetworkImage(model.imageUrl),
                        child: InkWell(
                          onTap: () {},
                        ),
                        height: 220,
                        fit: BoxFit.cover
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        left: 16,
                        child: Text(
                          model.predicted,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ]
                  )
                );
              }
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () async {
            await _showSelectionDialog(context);
            if(source != null) {
              try {
                PickedFile image = await controller.imagePick(source);
                if(image != null) {
                  setState(() {
                    source = null;
                  });
                  Modular.to.pushNamed('/prediction', arguments: {"uid": widget.uid, "image": image});
                } else {
                  setState(() {
                    source = null;
                  });
                }
              } on Exception catch(ex) {
                print(ex);
              }
            }
          },
          child: Icon(
            Icons.camera_alt
          ),
        ),
      )
    );
  }
}