import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/function/route_function.dart';
import '../../../../constants/list.dart';
import '../../../../models/spending.dart';
import '../../../../setting/localization/app_localizations.dart';
import '../view_list_spending_page.dart';

class ItemSpendingWidget extends StatelessWidget {
  const ItemSpendingWidget({Key? key, this.spendingList}) : super(key: key);
  final List<Spending>? spendingList;

  @override
  Widget build(BuildContext context) {
    return spendingList != null
        ? ListView.builder(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: listType.length,
            itemBuilder: (context, index) {
              if ([0, 10, 21, 27, 35, 38].contains(index)) {
                return const SizedBox.shrink();
              } else {
                var list = spendingList!
                    .where((element) => element.type == index)
                    .toList();
                if (list.isNotEmpty) {
                  return body(context, index, list);
                } else {
                  return const SizedBox.shrink();
                }
              }
            },
          )
        : loadingItemSpending();
  }

  Widget body(BuildContext context, int index, List<Spending> list) {
    var numberFormat = NumberFormat.currency(locale: "vi_VI");

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.of(context).push(createRoute(
          screen: ViewListSpendingPage(spendingList: list),
          begin: const Offset(1, 0),
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            children: [
              Image.asset(listType[index]["image"]!, width: 40),
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
                  numberFormat.format(list
                      .map((e) => e.money)
                      .reduce((value, element) => value + element)),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward_ios_outlined)
            ],
          ),
        ),
      ),
    );
  }
}

Widget loadingItemSpending() {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(10),
    itemCount: 10,
    itemBuilder: (context, index) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
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
                  const SizedBox(width: 10),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget textLoading(int width, {int height = 25}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height.toDouble(),
      width: width.toDouble(),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}
