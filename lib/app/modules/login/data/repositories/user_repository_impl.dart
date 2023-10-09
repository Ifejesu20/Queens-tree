import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/login/domain/repositories/user_repository.dart';
import 'package:eden/app/modules/login/presentation/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/user_repository.dart';
import '../../presentation/entity/user_entity.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<Exception, User>> signUp(UserEntity credential) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential result = await auth.createUserWithEmailAndPassword(email: credential.email, password: credential.password);
      User user = result.user;
      return Right(user);
    } on FirebaseAuthException catch(error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, User>> signIn(UserEntity credential) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential result = await auth.signInWithEmailAndPassword(email: credential.email, password: credential.password);
      User user = result.user;
      return Right(user);
    } on FirebaseAuthException catch(error) {
      return Left(error);
    }
  }
}