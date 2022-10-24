import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/constants/function/list_categories.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/main/analytic/view_list_spending_page.dart';

Widget showListSpending({required List<Spending> list}) {
  var numberFormat = NumberFormat.currency(locale: "vi_VI");
  int sum =
      list.map((e) => e.money).reduce((value, element) => value + element);

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: categories.length,
    itemBuilder: (context, index) {
      if ([0, 10, 21, 27, 35, 38].contains(index)) {
        return const SizedBox.shrink();
      } else {
        List<Spending> spendingList =
            list.where((element) => element.type == index).toList();
        if (spendingList.isNotEmpty) {
          int sumSpending = spendingList
              .map((e) => e.money)
              .reduce((value, element) => value + element);

          return InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewListSpendingPage(spendingList: spendingList),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  children: [
                    Image.asset(
                      categories[index]["icon"]!,
                      width: 40,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        categories[index]["name"]!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      numberFormat.format(sumSpending),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${((sumSpending / sum) * 100).toStringAsFixed(2)}%",
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward_ios_outlined)
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }
    },
  );
}
