import 'package:eden/app/modules/feed/domain/repositories/feed_repository.dart';

abstract class SignOut {
  Future<void> call();
}

class SignOutImpl implements SignOut {
  final FeedRepository feedRepository;

  SignOutImpl(this.feedRepository);

  @override
  Future<void> call() async {
    await feedRepository.signOut();
  }
}