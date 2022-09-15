abstract class LoginState {}

enum Social { email, google, facebook }

class InitState extends LoginState {}

class LoginSuccessState extends LoginState {
  final Social social;
  LoginSuccessState({required this.social});
}

class LoginErrorState extends LoginState {}
