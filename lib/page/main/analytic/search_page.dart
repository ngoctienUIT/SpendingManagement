import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spending_management/constants/function/list_categories.dart';
import 'package:spending_management/controls/spending_firebase.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/main/analytic/widget/filter_page.dart';
import 'package:spending_management/page/main/analytic/widget/item_spending_day.dart';
import 'package:spending_management/page/main/analytic/widget/my_search_delegate.dart';
import 'package:table_calendar/table_calendar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String? query;
  List<int> chooseIndex = [0, 0, 0, 0];
  int money = 0;
  DateTime? dateTime;
  String note = "";

  bool checkResult(Spending spending) {
    if (!categories[spending.type]["name"]!
        .toUpperCase()
        .contains(query!.toUpperCase())) return false;

    if (chooseIndex[0] == 1 && spending.money < money) {
      return false;
    } else if (chooseIndex[0] == 2 && spending.money > money) {
      return false;
    } else if (chooseIndex[0] == 4 && spending.money == money) {
      return false;
    }

    if (chooseIndex[2] == 1 && dateTime!.isAfter(spending.dateTime)) {
      return false;
    } else if (chooseIndex[2] == 2 && dateTime!.isBefore(spending.dateTime)) {
      return false;
    } else if (chooseIndex[2] == 4 && isSameDay(spending.dateTime, dateTime)) {
      return false;
    }

    if (spending.note != null && !spending.note!.contains(note)) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Tìm kiếm",
          ),
          onTap: () async {
            query = await showSearch(
              context: context,
              delegate: MySearchDelegate(
                text: "Tìm kiếm",
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterPage(
                    action: (list, money, dateTime, note) {
                      setState(() {
                        this.dateTime = dateTime;
                        this.money = money;
                        this.note = note;
                        chooseIndex = list;
                      });
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
                            return const Center(
                              child: Text(
                                "Không có gì ở đây!",
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          }
                          return itemSpendingDay(list);
                        }
                        return const Center(child: CircularProgressIndicator());
                      });
                }
                return const Center(child: CircularProgressIndicator());
              }),
    );
  }
}
