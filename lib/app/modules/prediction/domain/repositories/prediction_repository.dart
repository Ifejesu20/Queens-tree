import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/prediction_entity.dart';

abstract class PredictionRepository {
  void loadModel();
  Future<Either<Exception, List<dynamic>>> prediction(PickedFile image);
  Future<DocumentReference> savePrediction(PredictionEntity prediction);
  Future<String> uploadFile(File file, String folder, String name, String extension);
  Future<DocumentSnapshot> getPredictionById(String uid);
  Future<void> updatePrediction(String predictionId, Map<String, dynamic> document);
}