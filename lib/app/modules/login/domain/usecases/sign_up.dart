import 'package:dartz/dartz.dart';
import 'package:eden/app/modules/login/presentation/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eden/app/modules/login/domain/repositories/user_repository.dart';

import '../../presentation/entity/user_entity.dart';
import '../repositories/user_repository.dart';

abstract class SignUp {
  Future<Either<Exception, User>> call(UserEntity credential);
}

class SignUpImpl implements SignUp {
  final UserRepository userRepository;

  SignUpImpl(this.userRepository);

  @override
  Future<Either<Exception, User>> call(UserEntity credential) async {
    return userRepository.signUp(credential);
  }
}