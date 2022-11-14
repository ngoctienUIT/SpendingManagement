enum Social { email, google, facebook, newUser }

abstract class LoginState {}

class InitState extends LoginState {}

class LoginSuccessState extends LoginState {
  final Social social;
  LoginSuccessState({required this.social});
}

class LoginErrorState extends LoginState {
  String status;
  LoginErrorState({required this.status});
}
