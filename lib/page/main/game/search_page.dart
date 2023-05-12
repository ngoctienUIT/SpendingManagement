import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../constants/function/extension.dart';
import '../../../../constants/function/route_function.dart';
import '../../../../constants/list.dart';
import '../../../../controls/spending_firebase.dart';
import '../../../../models/filter.dart';
import '../../../../models/spending.dart';
import '../../../../page/main/game/widget/filter_page.dart';
import '../../../../page/main/game/widget/my_search_delegate.dart';
import '../../../../page/main/home/widget/item_spending_day.dart';
import '../../../../setting/localization/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String? query;
  Filter filter = Filter(chooseIndex: [0, 0, 0], friends: [], colors: []);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool checkResult(Spending spending) {
    if (!AppLocalizations.of(context)
        .translate(listType[spending.type]["title"]!)
        .toUpperCase()
        .contains(query!.toUpperCase())) return false;

    if (filter.chooseIndex[0] == 1 && spending.money.abs() < filter.money) {
      return false;
    } else if (filter.chooseIndex[0] == 2 &&
        spending.money.abs() > filter.money) {
      return false;
    } else if (filter.chooseIndex[0] == 3 &&
        (spending.money.abs() > filter.finishMoney ||
            spending.money.abs() < filter.money)) {
      return false;
    } else if (filter.chooseIndex[0] == 4 &&
        spending.money.abs() == filter.money) {
      return false;
    }

    if (filter.chooseIndex[1] == 1 &&
        filter.time!.isAfter(spending.dateTime.formatToDate())) {
      return false;
    } else if (filter.chooseIndex[1] == 2 &&
        filter.time!.isBefore(spending.dateTime.formatToDate())) {
      return false;
    } else if (filter.chooseIndex[1] == 3 &&
        (spending.dateTime.formatToDate().isAfter(filter.finishTime!) ||
            spending.dateTime.formatToDate().isBefore(filter.time!))) {
      return false;
    } else if (filter.chooseIndex[1] == 4 &&
        isSameDay(spending.dateTime, filter.time)) {
      return false;
    }

    if (filter.chooseIndex[2] == 1 && spending.money < 0) {
      return false;
    } else if (filter.chooseIndex[2] == 2 && spending.money > 0) {
      return false;
    }

    if (filter.friends!.isNotEmpty) {
      List<String> list = filter.friends!
          .where((element) => spending.friends!.contains(element))
          .toList();

      if (list.isEmpty) return false;
    }

    if (spending.note != null && !spending.note!.contains(filter.note)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: AppLocalizations.of(context).translate('search'),
          ),
          onTap: () async {
            query = await showSearch(
              context: context,
              delegate: MySearchDelegate(
                text: AppLocalizations.of(context).translate('search'),
                q: _searchController.text,
              ),
            );
            setState(() {
              _searchController.text = query!;
            });
          },
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                createRoute(
                  screen: FilterPage(
                    filter: filter,
                    action: (filter) {
                      setState(() => this.filter = filter.copyWith());
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.tune_rounded),
          )
        ],
      ),
      body: query == null
          ? Container()
          : FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("data")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data =
              snapshot.requireData.data() as Map<String, dynamic>;
              List<String> list = [];
              for (var element in data.entries) {
                list.addAll((element.value as List<dynamic>)
                    .map((e) => e.toString())
                    .toList());
              }
              return FutureBuilder(
                  future: SpendingFirebase.getSpendingList(list),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var spendingList = snapshot.data;
                      var list = spendingList!.where(checkResult).toList();
                      if (list.isEmpty) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('nothing_here'),
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      }
                      return ItemSpendingDay(spendingList: list);
                    }
                    return const Center(child: CircularProgressIndicator());
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
