enum Social { email, google, facebook }

abstract class LoginState {}

class InitState extends LoginState {}

class LoginSuccessState extends LoginState {
  final Social social;
  LoginSuccessState({required this.social});
}

class LoginErrorState extends LoginState {}
