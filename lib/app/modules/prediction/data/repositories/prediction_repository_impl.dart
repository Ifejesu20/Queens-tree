import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/prediction/data/datasource/prediction_datasource.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:eden/app/modules/prediction/domain/repositories/prediction_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../../domain/entities/prediction_entity.dart';
import '../../domain/repositories/prediction_repository.dart';
import '../datasource/prediction_datasource.dart';

class PredictionRepositoryImpl implements PredictionRepository {
  final PredictionDataSource firebaseDataSource;

  PredictionRepositoryImpl(this.firebaseDataSource);

  @override
  void loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt"
    );
  }

  @override
  Future<Either<Exception, List<dynamic>>> prediction(PickedFile image) async {
    try {
      List<dynamic> output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5
      );
      return Right(output);
    } on Exception catch(ex) {
      return Left(ex);
    }
  }

  @override
  Future<DocumentReference> savePrediction(PredictionEntity prediction) async =>
    await firebaseDataSource.savePrediction(prediction);

  @override
  Future<String> uploadFile(File file, String folder, String name, String extension) async =>
    await firebaseDataSource.uploadFile(file, folder, name, extension);

  @override
  Future<DocumentSnapshot> getPredictionById(String uid) async =>
    await firebaseDataSource.getPredictionById(uid);

  @override
  Future<void> updatePrediction(String predictionId, Map<String, dynamic> document) async =>
    await firebaseDataSource.updatePrediction(predictionId, document);
}