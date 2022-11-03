import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spending_management/page/login/bloc/login_event.dart';
import 'package:spending_management/page/login/bloc/login_state.dart';
import 'package:spending_management/models/user.dart' as myuser;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String _status = "";

  LoginBloc() : super(InitState()) {
    on<LoginWithEmailPasswordEvent>((event, emit) async {
      bool check = await signInWithEmailAndPassword(
          emailAddress: event.email, password: event.password);
      if (check) {
        SharedPreferences.getInstance().then((value) {
          value.setBool("login", true);
        });
        emit(LoginSuccessState(social: Social.email));
      } else {
        emit(LoginErrorState(status: _status));
      }
    });

    on<LoginWithGoogleEvent>((event, emit) async {
      UserCredential? user = await signInWithGoogle();
      if (user != null) {
        SharedPreferences.getInstance().then((value) {
          value.setBool("login", false);
        });
        await initInfoUser();
        emit(LoginSuccessState(social: Social.google));
      } else {
        emit(LoginErrorState(status: _status));
      }
    });

    on<LoginWithFacebookEvent>((event, emit) async {
      bool check = await signInWithFacebook();
      if (check) {
        SharedPreferences.getInstance().then((value) {
          value.setBool("login", false);
        });
        await initInfoUser();
        emit(LoginSuccessState(social: Social.facebook));
      } else {
        emit(LoginErrorState(status: _status));
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return null;
  }

  Future<bool> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken != null) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      return true;
    }

    return false;
  }

  Future<bool> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      _status = e.code;
      return false;
    }
  }

  Future initInfoUser() async {
    var firestore = FirebaseFirestore.instance
        .collection("info")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await firestore.get().then((value) async {
      if (!value.exists) {
        await firestore.set(myuser.User(
                name: FirebaseAuth.instance.currentUser!.displayName.toString(),
                birthday: DateFormat("dd/MM/yyyy").format(DateTime.now()),
                avatar: FirebaseAuth.instance.currentUser!.photoURL.toString())
            .toMap());
      }
    });
  }
}
