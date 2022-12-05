import 'package:spending_management/constants/function/route_function.dart';
import 'package:spending_management/constants/list.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/main/home/widget/item_spending_widget.dart';
import 'package:spending_management/page/view_spending/view_spending_page.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildSpending extends StatelessWidget {
  const BuildSpending({Key? key, this.spendingList, this.date, this.change})
      : super(key: key);
  final List<Spending>? spendingList;
  final DateTime? date;
  final Function(Spending spending)? change;

  @override
  Widget build(BuildContext context) {
    return spendingList != null
        ? (spendingList!.isEmpty
        ? Center(
      child: Text(
        "${AppLocalizations.of(context).translate('you_have_spending_the_day')} ${DateFormat("dd/MM/yyyy").format(date!)}",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.red.withOpacity(0.7),
        ),
        textAlign: TextAlign.center,
      ),
    )
        : showListSpending(spendingList!))
        : loadingItemSpending();
  }

  Widget showListSpending(List<Spending> spendingList) {
    var numberFormat = NumberFormat.currency(locale: "vi_VI");

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: spendingList.length,
      itemBuilder: (context, index) {
        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.of(context).push(createRoute(
              screen: ViewSpendingPage(
                spending: spendingList[index],
                change: (spending) {
                  if (change != null) change!(spending);
                },
              ),
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
                  Image.asset(
                    listType[spendingList[index].type]["image"]!,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Text(
                      spendingList[index].type == 41
                          ? spendingList[index].typeName!
                          : AppLocalizations.of(context).translate(
                          listType[spendingList[index].type]["title"]!),
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
                      numberFormat.format(spendingList[index].money),
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
      },
    );
  }
}