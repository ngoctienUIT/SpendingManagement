import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate<String> {
  String q;
  bool check = true;
  String text;

  MySearchDelegate({required this.text, required this.q}) {
    query = q;
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        TextButton(
          onPressed: () {
            close(context, query);
          },
          child: Text(text),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, q);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
      );

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (check) {
      query = q;
      check = false;
    }

    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("history")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var snapshotData = snapshot.requireData.data();
          if (snapshotData == null) return Container();

          var data = snapshotData;
          List<String> history = (data["history"] as List<dynamic>)
              .map((e) => e.toString())
              .where((element) =>
                  element.toUpperCase().contains(query.toUpperCase()))
              .toList()
              .reversed
              .toList();

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  query = history[index];
                  showResults(context);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(
                          history[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            query = history[index];
                          },
                          icon: const Icon(Icons.call_made_rounded),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const Divider(
                      height: 1,
                      endIndent: 20,
                      indent: 20,
                      color: Colors.black38,
                    )
                  ],
                ),
              );
            },
          );
        }
        return const Center(child: SingleChildScrollView());
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    // super.showResults(context);
    if (query.isNotEmpty) {
      var firestore = FirebaseFirestore.instance
          .collection("history")
          .doc(FirebaseAuth.instance.currentUser!.uid);

      firestore.get().then((value) {
        var data = {};
        if (value.data() != null) {
          data = value.data() as Map<String, dynamic>;
        }
        List<String> history = [];
        if (data["history"] != null) {
          history = (data["history"] as List<dynamic>)
              .map((e) => e.toString())
              .toList();
        }
        history.remove(query);
        history.add(query);
        if (value.data() == null) {
          firestore.set({"history": history});
        } else {
          firestore.update({"history": history});
        }
      });
      close(context, query);
    }
  }

  @override
  String? get searchFieldLabel => text;

  @override
  TextStyle? get searchFieldStyle =>
      const TextStyle(color: Colors.black54, fontSize: 18);
}
