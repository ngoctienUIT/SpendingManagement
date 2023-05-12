import '../../../../constants/function/get_date.dart';
import '../../../../constants/function/route_function.dart';
import '../../../../constants/list.dart';
import '../../../../models/spending.dart';
import '../../../../page/main/calendar/widget/custom_table_calendar.dart';
import '../../../../page/main/home/view_list_spending_page.dart';
import '../../../../setting/bloc/setting_cubit.dart';
import '../../../../setting/bloc/setting_state.dart';
import '../../../../setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ShowListSpendingColumn extends StatefulWidget {
  const ShowListSpendingColumn({
    Key? key,
    required this.spendingList,
    required this.index,
  }) : super(key: key);
  final List<Spending> spendingList;
  final int index;

  @override
  State<ShowListSpendingColumn> createState() => _ShowListSpendingColumnState();
}

class _ShowListSpendingColumnState extends State<ShowListSpendingColumn> {
  var numberFormat = NumberFormat.currency(locale: "vi_VI");

  @override
  Widget build(BuildContext context) {
    List<DateTime> listDate = widget.index == 0
        ? getListDayOfWeek(widget.spendingList[0].dateTime)
        : (widget.index == 1
        ? getListWeekOfMonth(widget.spendingList[0].dateTime)
        : getListMonthOfYear(widget.spendingList[0].dateTime));

    return BlocBuilder<SettingCubit, SettingState>(
        buildWhen: (previous, current) => previous != current,
        builder: (_, settingState) {
          return body(listDate, settingState.locale.languageCode);
        });
  }

  Widget body(List<DateTime> listDate, String lang) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listDate.length,
      itemBuilder: (context, index) {
        List<Spending> list = widget.index == 0
            ? widget.spendingList
            .where(
                (element) => isSameDay(element.dateTime, listDate[index]))
            .toList()
            : (widget.index == 1
            ? widget.spendingList
            .where((element) =>
            checkOnWeek(listDate[index], element.dateTime))
            .toList()
            : widget.spendingList
            .where((element) =>
            isSameMonth(element.dateTime, listDate[index]))
            .toList());

        if (list.isEmpty) {
          return const SizedBox.shrink();
        }

        return Card(
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
                      widget.index == 0
                          ? DateFormat("dd").format(listDate[index])
                          : (index + 1).toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.index == 0
                              ? DateFormat.EEEE(lang).format(listDate[index])
                              : "${AppLocalizations.of(context).translate((widget.index == 1 ? "week" : "month"))} ${index + 1}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(DateFormat.yMMMM(lang).format(listDate[index]))
                      ],
                    ),
                    const Spacer(),
                    Text(
                      list.isNotEmpty
                          ? numberFormat.format(list
                          .map((e) => e.money)
                          .reduce((value, element) => value + element))
                          : "0 VND",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              if (list.isNotEmpty)
                const Divider(
                  height: 2,
                  color: Colors.black,
                  endIndent: 10,
                  indent: 10,
                ),
              if (list.isNotEmpty) buildItem(list),
            ],
          ),
        );
      },
    );
  }

  Widget buildItem(List<Spending> listSpending) {
    return Column(
      children: List.generate(listType.length, (index) {
        List<Spending> list =
        listSpending.where((element) => element.type == index).toList();

        if (list.isEmpty) {
          return const SizedBox.shrink();
        }

        return InkWell(
          onTap: () {
            Navigator.of(context).push(createRoute(
              screen: ViewListSpendingPage(spendingList: list),
              begin: const Offset(1, 0),
            ));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset(listType[index]["image"]!, width: 40),
                const SizedBox(width: 10),
                Container(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: Text(
                    AppLocalizations.of(context)
                        .translate(listType[index]["title"]!),
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
                    numberFormat.format(list
                        .map((e) => e.money)
                        .reduce((value, element) => value + element)),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
