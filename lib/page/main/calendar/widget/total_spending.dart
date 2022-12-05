import 'dart:math';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerAnimation() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 25,
      width: Random().nextInt(30) + 90,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

class TotalSpending extends StatelessWidget {
  const TotalSpending({Key? key, this.list}) : super(key: key);
  final List<Spending>? list;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(locale: "vi_VI");

    int income = 0;
    int spending = 0;

    if (list != null) {
      List<Spending> incomeList =
      list!.where((element) => element.money > 0).toList();
      if (incomeList.isNotEmpty) {
        income = incomeList
            .map((e) => e.money)
            .reduce((value, element) => value + element);
      }
      List<Spending> spendingList =
      list!.where((element) => element.money < 0).toList();
      if (spendingList.isNotEmpty) {
        spending = spendingList
            .map((e) => e.money)
            .reduce((value, element) => value + element);
      }
    }

    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        // color: Theme.of(context).backgroundColor,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(AppLocalizations.of(context).translate('income')),
                  const SizedBox(height: 5),
                  list != null
                      ? Text(
                    numberFormat.format(income),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  )
                      : shimmerAnimation()
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(AppLocalizations.of(context).translate('spending')),
                  const SizedBox(height: 5),
                  list != null
                      ? Text(
                    list!.isNotEmpty
                        ? numberFormat.format(spending)
                        : "0",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  )
                      : shimmerAnimation()
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(AppLocalizations.of(context).translate('total')),
                  const SizedBox(height: 5),
                  list != null
                      ? Text(
                    list!.isNotEmpty
                        ? numberFormat.format(income + spending)
                        : "0",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  )
                      : shimmerAnimation()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}