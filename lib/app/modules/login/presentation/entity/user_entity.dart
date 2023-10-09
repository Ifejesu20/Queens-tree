class UserEntity {
  final String email;
  final String password;

  UserEntity._({this.email, this.password});

  factory UserEntity.user({String email, String password}) {
    return UserEntity._(
      email: email,
      password: password
    );
  }
}