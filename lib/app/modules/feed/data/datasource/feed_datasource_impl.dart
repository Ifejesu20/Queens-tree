

import '../../../prediction/data/models/prediction_model.dart';
import '../../../prediction/domain/entities/prediction_entity.dart';
import 'feed_datasource.dart';

class FeedDataSourceImpl implements FeedDataSource {
  FirebaseFirestore firestoreInstance;
  FirebaseAuth authInstance;

  FeedDataSourceImpl({this.firestoreInstance, this.authInstance}) {
    this.firestoreInstance = FirebaseFirestore.instance;
    this.authInstance = FirebaseAuth.instance;
  }

  @override
  Stream<List<PredictionEntity>> getUserPredictions(String uid) {
    final predictionCollectionRef = firestoreInstance.collection("predictions").where("user", isEqualTo: uid);
    return predictionCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
        .map((docQuerySnapshot) => PredictionModel.fromSnapshot(docQuerySnapshot))
        .toList();
    });
  }

  @override
  Future<void> signOut() async {
    if(authInstance.currentUser != null) {
      await authInstance.signOut();
    } else {
      throw Exception("Is already signed out!");
    }
  }
}