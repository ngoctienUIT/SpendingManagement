import 'package:flutter/material.dart';
import 'package:spending_management/constants/app_styles.dart';

class AnalyticPage extends StatefulWidget {
  const AnalyticPage({Key? key}) : super(key: key);

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: const [
                  Text(
                    "Spending",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 40,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(242, 243, 247, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black87,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
                    unselectedLabelStyle: AppStyles.p,
                    isScrollable: false,
                    indicatorColor: Colors.red,
                    indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    tabs: const [
                      Tab(text: "Weekly"),
                      Tab(text: "Monthly"),
                      Tab(text: "Yearly")
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
