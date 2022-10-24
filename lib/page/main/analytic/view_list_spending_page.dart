import 'package:flutter/material.dart';
import 'package:spending_management/constants/function/list_categories.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/main/analytic/widget/item_spending_day.dart';

class ViewListSpendingPage extends StatelessWidget {
  const ViewListSpendingPage({Key? key, required this.spendingList})
      : super(key: key);
  final List<Spending> spendingList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Text(
            categories[spendingList[0].type]["name"]!,
            style: const TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          centerTitle: true,
        ),
        body: itemSpendingDay(spendingList));
  }
}
