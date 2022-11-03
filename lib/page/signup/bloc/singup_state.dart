abstract class SignupState {}

class InitState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupErrorState extends SignupState {
  String status;
  SignupErrorState({required this.status});
}
