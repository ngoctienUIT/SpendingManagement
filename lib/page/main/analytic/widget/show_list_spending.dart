import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/constants/function/list_categories.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/main/analytic/view_list_spending_page.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';

Widget showListSpending({required List<Spending> list, required int type}) {
  var numberFormat = NumberFormat.currency(locale: "vi_VI");
  int sum = list.isNotEmpty
      ? list.map((e) => e.money).reduce((value, element) => value + element)
      : 1;

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: type == 0 ? categories.length : income.length,
    itemBuilder: (context, index) {
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
                builder: (context) => ViewListSpendingPage(
                    spendingList: spendingList, type: type),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                children: [
                  Image.asset(
                    type == 0
                        ? categories[index]["icon"]!
                        : income[index]["icon"],
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Text(
                      AppLocalizations.of(context).translate(type == 0
                          ? categories[index]["name"]!
                          : income[index]["name"]),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      numberFormat.format(sumSpending),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: Text(
                      "${((sumSpending / sum) * 100).toStringAsFixed(2)}%",
                      style: const TextStyle(fontSize: 13),
                      textAlign: TextAlign.end,
                    ),
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
    },
  );
}
