import 'package:spending_management/constants/list.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget showListSpending({required List<Spending> list}) {
  var numberFormat = NumberFormat.currency(locale: "vi_VI");
  int sum = list.isNotEmpty
      ? list.map((e) => e.money).reduce((value, element) => value + element)
      : 1;

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: listType.length,
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
              // Navigator.of(context).push(createRoute(
              //   screen: ViewListSpendingPage(spendingList: spendingList),
              //   begin: const Offset(1, 0),
              // ));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  children: [
                    Image.asset(
                      listType[index]["image"]!,
                      width: 40,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate(listType[index]["title"]!),
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
      }
    },
  );
}
