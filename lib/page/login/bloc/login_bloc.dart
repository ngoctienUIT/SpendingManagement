import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/page/login/bloc/login_event.dart';
import 'package:spending_management/page/login/bloc/login_state.dart';
import 'package:spending_management/models/user.dart' as myuser;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitState()) {
    on<LoginWithEmailPasswordEvent>((event, emit) async {
      bool check = await signInWithEmailAndPassword(
          emailAddress: event.email, password: event.password);
      if (check) {
        emit(LoginSuccessState(social: Social.email));
      } else {
        emit(LoginErrorState());
      }
    });

    on<LoginWithGoogleEvent>((event, emit) async {
      UserCredential? user = await signInWithGoogle();
      if (user != null) {
        await initInfoUser();
        emit(LoginSuccessState(social: Social.google));
      } else {
        emit(LoginErrorState());
      }
    });

    on<LoginWithFacebookEvent>((event, emit) async {
      bool check = await signInWithFacebook();
      if (check) {
        await initInfoUser();
        emit(LoginSuccessState(social: Social.facebook));
      } else {
        emit(LoginErrorState());
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
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
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
