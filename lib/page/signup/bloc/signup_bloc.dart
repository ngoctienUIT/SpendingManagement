import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/page/signup/bloc/signup_event.dart';
import 'package:spending_management/page/signup/bloc/singup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(InitState()) {
    on<SignupEmailPasswordEvent>((event, emit) async {
      bool check =
          await createAccount(email: event.email, password: event.password);
      if (check) {
        emit(SignupSuccessState());
      } else {
        emit(SignupErrorState());
      }
    });
  }

  Future<bool> createAccount(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
