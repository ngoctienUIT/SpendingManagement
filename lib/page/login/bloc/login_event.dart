abstract class LoginEvent {}

class LoginWithEmailPasswordEvent extends LoginEvent {
  String email;
  String password;

  LoginWithEmailPasswordEvent({required this.email, required this.password});
}

class LoginWithGoogleEvent extends LoginEvent {}

class LoginWithFacebookEvent extends LoginEvent {}
