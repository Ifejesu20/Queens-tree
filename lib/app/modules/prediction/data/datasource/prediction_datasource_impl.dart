import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:eden/app/modules/prediction/data/datasource/prediction_datasource.dart';
import 'package:eden/app/modules/prediction/data/models/prediction_model.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';

import '../../domain/entities/prediction_entity.dart';
import '../models/prediction_model.dart';
import 'prediction_datasource.dart';

class FirebaseDataSourceImpl implements PredictionDataSource {
  FirebaseFirestore firestoreInstance;
  FirebaseStorage storageInstance;
  FirebaseAuth auth;

  FirebaseDataSourceImpl({this.firestoreInstance, this.storageInstance, this.auth}) {
    this.firestoreInstance = FirebaseFirestore.instance;
    this.storageInstance = FirebaseStorage.instance;
    this.auth = FirebaseAuth.instance;
  }

  @override
  Future<DocumentReference> savePrediction(PredictionEntity prediction) async {
    final user = auth.currentUser;

    final newPrediction = PredictionModel(
      user: user.uid,
      imageUrl: prediction.imageUrl,
      predicted: prediction.predicted,
      confidence: prediction.confidence,
      details: prediction.details,
      isCorrect: prediction.isCorrect,
      isHidden: prediction.isHidden,
    ).toDocument();

    return await firestoreInstance.collection("predictions").add(newPrediction);
  }

  @override
  Future<String> uploadFile(File file, String folder, String name, String extension) async {
    String ext = extension.length > 0 ? "." + extension : "";

    TaskSnapshot snapshot = await storageInstance.ref().child(folder + "/" + name + ext).putFile(file);
    if(snapshot.state == TaskState.success) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    }
  }

  @override
  Future<DocumentSnapshot> getPredictionById(String uid) async {
    return await firestoreInstance.collection("predictions").doc(uid).get();
  }

  @override
  Future<void> updatePrediction(String predictionId, Map<String, dynamic> document) async {
    await firestoreInstance.collection("predictions").doc(predictionId).set(document);
  }
}