import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/constants/function/list_categories.dart';
import 'package:spending_management/controls/spending_firebase.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';

class InputIncome extends StatefulWidget {
  const InputIncome({Key? key}) : super(key: key);

  @override
  State<InputIncome> createState() => _InputIncomeState();
}

class _InputIncomeState extends State<InputIncome> {
  DateTime dateTime = DateTime.now();
  int activeCategory = 0;
  Color primary = const Color(0xFFFF3378);
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    AppLocalizations.of(context).translate('income_date'),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: CupertinoButton(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Text(
                      "${DateFormat("dd/MM/yyyy").format(dateTime)} (${dateTime.weekday})",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => SizedBox(
                          height: 280,
                          child: CupertinoDatePicker(
                            backgroundColor: Colors.white,
                            initialDateTime: dateTime,
                            onDateTimeChanged: (DateTime newTime) {
                              setState(() => dateTime = newTime);
                            },
                            use24hFormat: true,
                            mode: CupertinoDatePickerMode.date,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    AppLocalizations.of(context).translate('note'),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .translate('more_details'),
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ]),
            child: Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    AppLocalizations.of(context).translate('income'),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _moneyController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [CurrencyTextInputFormatter(locale: "vi")],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('please_enter_the_amount');
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: '10.000 VND',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30, width: 35),
              Text(
                AppLocalizations.of(context).translate('category'),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            padding: const EdgeInsets.only(top: 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(income.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => activeCategory = index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 5, top: 10, bottom: 10),
                        width: 100,
                        height: 110,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: activeCategory == index
                                ? primary
                                : Colors.transparent,
                            width: activeCategory == index ? 2 : 0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 3,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 10, top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: ImageIcon(
                                    AssetImage(income[index]['icon']),
                                    color: Colors.black87,
                                    size: 40,
                                  ),
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)
                                    .translate(income[index]['name']),
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await SpendingFirebase.addSpending(
                      Spending(
                        money: int.parse(_moneyController.text
                            .replaceAll(RegExp(r'[^0-9]'), '')),
                        note: _noteController.text,
                        type: activeCategory,
                        dateTime: dateTime,
                      ),
                    );
                    if (!mounted) return;
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black54),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                child: Text(AppLocalizations.of(context).translate('save')),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
