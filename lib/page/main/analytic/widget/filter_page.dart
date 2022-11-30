import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/page/main/analytic/widget/item_filter.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key, required this.action}) : super(key: key);
  final Function(List<int> list, int money, DateTime? dateTime, String note)
      action;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<String> moneyList = [
    "Tất cả",
    "Lớn hơn",
    "Nhỏ hơn",
    "Trong khoảng",
    "Chính xác"
  ];

  List<String> timeList = [
    "Tất cả",
    "Sau",
    "Trước",
    "Trong khoảng",
    "Chính xác"
  ];

  List<String> groupList = [
    "Tất cả các khoản",
    "Tất cả các khoàn thu",
    "Tất cả các khoản chi"
  ];

  List<int> chooseIndex = [0, 0, 0, 0];
  TextEditingController moneyController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bộ lọc",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close_rounded),
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.action(
                chooseIndex,
                moneyController.text.isEmpty
                    ? 0
                    : int.parse(
                        moneyController.text.replaceAll(RegExp(r'[^0-9]'), '')),
                dateTime,
                noteController.text,
              );
              Navigator.pop(context);
            },
            child: const Text(
              "Tìm kiếm",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          )
        ],
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              itemFilter(
                text: "Số tiền",
                value: chooseIndex[0] == 0
                    ? moneyList[chooseIndex[0]]
                    : "${moneyList[chooseIndex[0]]} ${moneyController.text}",
                list: moneyList,
                action: (value) async {
                  if (value != 0) {
                    await inputMoney();
                  }
                  setState(() => chooseIndex[0] = value);
                },
              ),
              line(),
              itemFilter(
                text: "Ví",
                value: moneyList[chooseIndex[1]],
                list: moneyList,
                action: (value) {
                  setState(() => chooseIndex[1] = value);
                },
              ),
              line(),
              itemFilter(
                text: "Thời gian",
                value: chooseIndex[2] == 0
                    ? timeList[chooseIndex[2]]
                    : "${timeList[chooseIndex[2]]} ${DateFormat("dd/MM/yyyy").format(dateTime!)}",
                list: timeList,
                action: (value) async {
                  if (value != 0) {
                    DateTime? picker = await chooseDate();
                    if (picker != null) dateTime = picker;
                  }
                  setState(() {
                    if (dateTime == null) {
                      chooseIndex[2] = 0;
                    } else {
                      chooseIndex[2] = value;
                    }
                  });
                },
              ),
              line(),
              Row(
                children: [
                  const SizedBox(
                    width: 70,
                    child: Text(
                      "Ghi chú",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: noteController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
                        ),
                        hintStyle: const TextStyle(fontSize: 16),
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: "Ghi chú",
                        contentPadding: const EdgeInsets.all(0),
                      ),
                    ),
                  ),
                ],
              ),
              line(),
              itemFilter(
                text: "Nhóm",
                value: groupList[chooseIndex[3]],
                list: groupList,
                action: (value) {
                  setState(() => chooseIndex[3] = value);
                },
              ),
              line()
            ],
          ),
        ),
      ),
    );
  }

  Widget line() {
    return const Divider(
      color: Colors.grey,
      thickness: 0.5,
      endIndent: 10,
      indent: 10,
    );
  }

  Future inputMoney() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: AlertDialog(
            content: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Nhập vào số tiền"),
                  const SizedBox(height: 10),
                  TextField(
                    controller: moneyController,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [CurrencyTextInputFormatter(locale: "vi")],
                    decoration: const InputDecoration(
                      hintText: '30.000 VND',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Ok"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<DateTime?> chooseDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
  }
}
