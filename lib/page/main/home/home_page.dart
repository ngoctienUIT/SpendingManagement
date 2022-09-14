import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/models/user.dart' as myuser;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late myuser.User user;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("info")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get()
        .then((value) => user = myuser.User.fromFirebase(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        centerTitle: true,
        leading: null,
      ),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }
}
