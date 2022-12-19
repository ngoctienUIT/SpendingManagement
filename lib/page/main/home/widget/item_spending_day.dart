import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../constants/list.dart';
import '../../../../models/spending.dart';
import '../../../../setting/bloc/setting_cubit.dart';
import '../../../../setting/bloc/setting_state.dart';
import '../../../../setting/localization/app_localizations.dart';
import '../../../view_spending/view_spending_page.dart';

class ItemSpendingDay extends StatefulWidget {
  const ItemSpendingDay({Key? key, required this.spendingList})
      : super(key: key);
  final List<Spending> spendingList;

  @override
  State<ItemSpendingDay> createState() => _ItemSpendingDayState();
}

class _ItemSpendingDayState extends State<ItemSpendingDay> {
  var numberFormat = NumberFormat.currency(locale: "vi_VI");

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    widget.spendingList.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    var listDate = widget.spendingList
        .map((e) => DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day))
        .toList()
        .toSet()
        .toList();

    return listDate.isNotEmpty
        ? BlocBuilder<SettingCubit, SettingState>(
            buildWhen: (previous, current) => previous != current,
            builder: (_, settingState) {
              return body(listDate, settingState.locale.languageCode);
            })
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('no_data'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
  }

  Widget body(List<DateTime> listDate, String lang) {
    return ListView.builder(
      itemCount: listDate.length,
      itemBuilder: (context, index) {
        var list = widget.spendingList
            .where((element) => isSameDay(element.dateTime, listDate[index]))
            .toList();

        return Padding(
          padding: const EdgeInsets.all(10),
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
                      Text(
                        DateFormat("dd").format(listDate[index]),
                        style: const TextStyle(fontSize: 30),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.EEEE(lang).format(listDate[index]),
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(DateFormat.yMMMM(lang).format(listDate[index]))
                        ],
                      ),
                      const Spacer(),
                      Text(
                        numberFormat.format(list
                            .map((e) => e.money)
                            .reduce((value, element) => value + element)),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black,
                  endIndent: 10,
                  indent: 10,
                ),
                listItem(list),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget listItem(List<Spending> list) {
    return Column(
      children: List.generate(
        list.length,
        (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewSpendingPage(
                    spending: list[index],
                    change: (spending) async {
                      try {
                        spending.image = await FirebaseStorage.instance
                            .ref()
                            .child("spending/${spending.id}.png")
                            .getDownloadURL();
                      } catch (_) {}
                      widget.spendingList.removeWhere((element) =>
                          element.id!.compareTo(spending.id!) == 0);
                      setState(() {
                        widget.spendingList.add(spending);
                      });
                    },
                    delete: (id) {
                      setState(() {
                        widget.spendingList.removeWhere(
                            (element) => element.id!.compareTo(id) == 0);
                      });
                    },
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(
                    listType[list[index].type]["image"]!,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Text(
                      list[index].type == 41
                          ? list[index].typeName!
                          : AppLocalizations.of(context)
                              .translate(listType[list[index].type]["title"]!),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      numberFormat.format(list[index].money),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 16),
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
