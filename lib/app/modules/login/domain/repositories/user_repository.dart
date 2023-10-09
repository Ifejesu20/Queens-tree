import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/login/presentation/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../presentation/entity/user_entity.dart';

abstract class UserRepository {
  Future<Either<Exception, User>> signUp(UserEntity credential);
  Future<Either<Exception, User>> signIn(UserEntity credential);
}