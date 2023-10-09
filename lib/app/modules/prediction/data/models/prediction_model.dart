import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eden/app/modules/prediction/domain/entities/prediction_entity.dart';

import '../../domain/entities/prediction_entity.dart';

class PredictionModel extends PredictionEntity {
  PredictionModel({
    String user,
    String imageUrl,
    String predicted,
    double confidence,
    String details,
    bool isCorrect,
    bool isHidden,
  }) : super(
    user: user,
    imageUrl: imageUrl,
    predicted: predicted,
    confidence: confidence,
    details: details,
    isCorrect: isCorrect,
    isHidden: isHidden,
  );

  factory PredictionModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PredictionModel(
      user: snapshot.data()['user'],
      imageUrl: snapshot.data()['imageUrl'],
      predicted: snapshot.data()['predicted'],
      confidence: snapshot.data()['confidence'],
      details: snapshot.data()['details'],
      isCorrect: snapshot.data()['isCorrect'],
      isHidden: snapshot.data()['isHidden'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "user": user,
      "imageUrl": imageUrl,
      "predicted": predicted,
      "confidence": confidence,
      "details": details,
      "isCorrect": isCorrect,
      "isHidden": isHidden,
    };
  }
}