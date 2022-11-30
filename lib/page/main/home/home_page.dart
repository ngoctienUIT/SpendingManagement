import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/main/home/widget/item_spending_widget.dart';
import 'package:spending_management/page/main/home/widget/summary_spending.dart';

import '../../../constants/app_styles.dart';
import '../../../setting/localization/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _monthController;
  List<DateTime> months = [];

  @override
  void initState() {
    _monthController = TabController(length: 19, vsync: this);
    _monthController.index = 17;
    _monthController.addListener(() {
      setState(() {});
    });
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month);
    months = [DateTime(now.year, now.month + 1), now];
    for (int i = 1; i < 19; i++) {
      now = DateTime(now.year, now.month - 1);
      months.add(now);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("data")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<String> list = [];

              if (snapshot.requireData.data() != null) {
                var data = snapshot.requireData.data() as Map<String, dynamic>;

                if (data[DateFormat("MM_yyyy")
                    .format(months[18 - _monthController.index])] !=
                    null) {
                  list = (data[DateFormat("MM_yyyy")
                      .format(months[18 - _monthController.index])]
                  as List<dynamic>)
                      .map((e) => e.toString())
                      .toList();
                }
              }

              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("spending")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var spendingList = snapshot.data!.docs
                        .where((element) => list.contains(element.id))
                        .map((e) => Spending.fromFirebase(e))
                        .toList();

                    return body(spendingList: spendingList);
                  }
                  return loading();
                },
              );
            }
            return loading();
          },
        ),
      ),
    );
  }

  Widget body({List<Spending>? spendingList}) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: TabBar(
            controller: _monthController,
            isScrollable: true,
            labelColor: Colors.black87,
            labelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
            unselectedLabelStyle: AppStyles.p,
            indicatorColor: Colors.green,
            tabs: List.generate(19, (index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Tab(
                  text: index == 17
                      ? AppLocalizations.of(context)
                      .translate('this_month')
                      .capitalize()
                      : (index == 18
                      ? AppLocalizations.of(context)
                      .translate('next_month')
                      .capitalize()
                      : (index == 16
                      ? AppLocalizations.of(context)
                      .translate('last_month')
                      .capitalize()
                      : DateFormat("MM/yyyy")
                      .format(months[18 - index]))),
                ),
              );
            }),
          ),
        ),
        SummarySpending(spendingList: spendingList),
        const SizedBox(height: 10),
        Text(
          "${AppLocalizations.of(context).translate('spending_list')} ${_monthController.index == 17 ? AppLocalizations.of(context).translate('this_month') : DateFormat("MM/yyyy").format(months[18 - _monthController.index])}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        spendingList!.isNotEmpty
            ? Expanded(child: ItemSpendingWidget(spendingList: spendingList))
            : Expanded(
          child: Center(
            child: Text(
              "${AppLocalizations.of(context).translate('no_data')} ${_monthController.index == 17 ? AppLocalizations.of(context).translate('this_month') : DateFormat("MM/yyyy").format(months[18 - _monthController.index])}!",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget loading() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context).translate('this_month').capitalize(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SummarySpending(),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context).translate('this_month_spending_list'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const ItemSpendingWidget(),
        ],
      ),
    );
  }
}
