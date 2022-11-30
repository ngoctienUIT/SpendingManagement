
import 'package:flutter/material.dart';

import '../../../constants/list.dart';
import '../../../models/spending.dart';
import '../../../setting/localization/app_localizations.dart';
import 'widget/item_spending_day.dart';

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
          spendingList[0].type == 41
              ? spendingList[0].typeName!
              : AppLocalizations.of(context)
                  .translate(listType[spendingList[0].type]["title"]!),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: ItemSpendingDay(spendingList: spendingList),
    );
  }
}
