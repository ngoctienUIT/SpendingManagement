import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/page/signup/bloc/signup_event.dart';
import 'package:spending_management/page/signup/bloc/singup_state.dart';
import 'package:spending_management/models/user.dart' as myuser;
import 'package:shared_preferences/shared_preferences.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  String _status = "";

  SignupBloc() : super(InitState()) {
    on<SignupEmailPasswordEvent>((event, emit) async {
      bool check =
          await createAccount(email: event.email, password: event.password);
      if (check) {
        SharedPreferences.getInstance().then((value) {
          value.setBool("login", true);
        });
        await initInfoUser(event.user);
        emit(SignupSuccessState());
      } else {
        emit(SignupErrorState(status: _status));
      }
    });
  }

  Future<bool> createAccount(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      _status = e.code;
      return false;
    }
  }

  Future initInfoUser(myuser.User user) async {
    var firestore = FirebaseFirestore.instance
        .collection("info")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await firestore.set(user
        .copyWith(avatar: FirebaseAuth.instance.currentUser!.photoURL)
        .toMap());
  }
}
