import 'package:spending_management/models/user.dart';

abstract class SignupEvent {}

class SignupEmailPasswordEvent extends SignupEvent {
  final String email;
  final String password;
  final User user;

  SignupEmailPasswordEvent(
      {required this.email, required this.password, required this.user});
}
