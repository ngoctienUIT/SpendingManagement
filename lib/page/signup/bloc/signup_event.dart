abstract class SignupEvent {}

class SignupEmailPasswordEvent extends SignupEvent {
  final String email;
  final String password;

  SignupEmailPasswordEvent({required this.email, required this.password});
}
