import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../models/user.dart' as myuser;
import '../../../../models/spending.dart';
import '../../../../setting/localization/app_localizations.dart';


class SummarySpending extends StatefulWidget {
  const SummarySpending({Key? key, this.spendingList}) : super(key: key);
  final List<Spending>? spendingList;

  @override
  State<SummarySpending> createState() => _SummarySpendingState();
}

class _SummarySpendingState extends State<SummarySpending> {
  final numberFormat = NumberFormat.currency(locale: "vi_VI");

  Future initWallet({Map<String, dynamic>? data}) async {
    FirebaseFirestore.instance
        .collection("info")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      myuser.User user = myuser.User.fromFirebase(value);
      var walletData = data ?? {};
      walletData
          .addAll({DateFormat("MM_yyyy").format(DateTime.now()): user.money});

      FirebaseFirestore.instance
          .collection("wallet")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(walletData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.spendingList != null
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("wallet")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.requireData.data() != null) {
                  var data = snapshot.requireData.data();
                  var wallet =
                      data![DateFormat("MM_yyyy").format(DateTime.now())];
                  int sum = 0;
                  if (widget.spendingList!.isNotEmpty) {
                    sum = widget.spendingList!
                        .map((e) => e.money)
                        .reduce((value, element) => value + element);
                  }
                  if (wallet != null) {
                    return body(wallet, sum);
                  } else {
                    initWallet(data: data);
                    return loadingSummary();
                  }
                } else {
                  initWallet();
                  return loadingSummary();
                }
              }
              return loadingSummary();
            })
        : loadingSummary();
  }

  Widget body(var wallet, var sum) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('first_balance'),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    numberFormat.format(wallet),
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('final_balance'),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    numberFormat.format(wallet + sum),
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    "${sum > 0 ? "+" : ""}${numberFormat.format(sum)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingSummary() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('first_balance'),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  textLoading()
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('final_balance'),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  textLoading()
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(height: 10),
              Row(
                children: [const Spacer(), textLoading()],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 25,
        width: Random().nextInt(50) + 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
