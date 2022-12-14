import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spending_management/page/main/home/widget/item_spending_day.dart';
import 'package:spending_management/page/main/home/widget/item_spending_widget.dart';

import '../../../controls/spending_firebase.dart';
import '../../../models/spending.dart';
import '../../../setting/localization/app_localizations.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(AppLocalizations.of(context).translate("history")),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("data")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = (snapshot.requireData.data() ?? <String, dynamic>{});
            List<String> listID = [];
            for (var list in data.values) {
              listID.addAll(
                  (list as List<dynamic>).map((e) => e.toString()).toList());
            }

            return FutureBuilder(
              future: SpendingFirebase.getSpendingList(listID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Spending> listSpending = snapshot.requireData;
                  listSpending.sort(
                          (a, b) => b.dateTime.difference(a.dateTime).inSeconds);

                  return ItemSpendingDay(spendingList: listSpending);
                }
                return loading();
              },
            );
          }
          return loading();
        },
      ),
    );
  }

  Widget loading() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        textLoading(40, height: 40),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textLoading(Random().nextInt(20) + 40),
                            const SizedBox(height: 5),
                            textLoading(Random().nextInt(50) + 50),
                          ],
                        ),
                        const Spacer(),
                        textLoading(Random().nextInt(70) + 50),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Column(
                    children: List.generate(
                      Random().nextInt(4) + 1,
                          (index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(90),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              textLoading(Random().nextInt(50) + 50),
                              const Spacer(),
                              textLoading(Random().nextInt(50) + 70),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
