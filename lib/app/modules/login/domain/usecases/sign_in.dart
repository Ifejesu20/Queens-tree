import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/login/domain/repositories/user_repository.dart';
import 'package:eden/app/modules/login/presentation/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../presentation/entity/user_entity.dart';
import '../repositories/user_repository.dart';

abstract class SignIn {
  Future<Either<Exception, User>> call(UserEntity user);
}

class SignInImpl implements SignIn {
  final UserRepository userRepository;

  SignInImpl(this.userRepository);

  @override
  Future<Either<Exception, User>> call(UserEntity credential) async {
    return userRepository.signIn(credential);
  }
}