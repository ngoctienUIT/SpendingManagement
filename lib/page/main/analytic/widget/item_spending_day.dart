import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/constants/function/list_categories.dart';
import 'package:spending_management/models/spending.dart';
import 'package:table_calendar/table_calendar.dart';

Widget itemSpendingDay(List<Spending> spendingList) {
  var numberFormat = NumberFormat.currency(locale: "vi_VI");

  spendingList.sort(
    (a, b) => b.dateTime.compareTo(a.dateTime),
  );

  var listDate = spendingList
      .map((e) => DateTime(e.dateTime.year, e.dateTime.month, e.dateTime.day))
      .toList()
      .toSet()
      .toList();

  return ListView.builder(
    itemCount: listDate.length,
    itemBuilder: (context, index) {
      var list = spendingList
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
                      "${listDate[index].day}",
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat("EEEE").format(listDate[index]),
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(DateFormat("MMMM, yyyy").format(listDate[index]))
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
              Column(
                children: List.generate(
                  list.length,
                  (index) => InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Image.asset(
                            categories[spendingList[0].type]["icon"]!,
                            width: 40,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            categories[spendingList[0].type]["name"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            numberFormat.format(list[index].money),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
