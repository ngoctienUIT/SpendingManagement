import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/constants/function/list_categories.dart';
import 'package:spending_management/controls/spending_firebase.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';

class InputSpending extends StatefulWidget {
  const InputSpending({Key? key}) : super(key: key);

  @override
  State<InputSpending> createState() => _InputSpendingState();
}

class _InputSpendingState extends State<InputSpending> {
  DateTime dateTime = DateTime.now();
  int activeCategory = 0;
  Color primary = const Color(0xFFFF3378);
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _moneyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: _formKey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 30),
               SizedBox(
                width: 70,
                child: Text(
                  AppLocalizations.of(context).translate('spending_date'),
                  style:const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: CupertinoButton(
                  color: Colors.black12,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Text(
                    "${DateFormat("dd/MM/yyyy").format(dateTime)} (${dateTime.weekday})",
                    style: const TextStyle(fontSize: 15, color: Colors.black),
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
                        // Column(
                        //   children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //   TextButton(
                        //     child:
                        //     Container(
                        //       padding: EdgeInsets.only(right: 8),
                        //       child:
                        //       Text('Hủy',style: TextStyle(fontSize: 18,color: Colors.redAccent),),
                        //     ),
                        //     onPressed: (){},
                        //   ),
                        //   TextButton(
                        //     child:
                        //     Container(
                        //       padding: EdgeInsets.only(right: 8),
                        //       child:
                        //       Text('Chọn',style: TextStyle(fontSize: 18,color: Colors.redAccent),),
                        //     ),
                        //     onPressed: (){},
                        //   ),
                        //   ],
                        // ),
                        //   Row(
                        //     children: [
                        //       Expanded(child:
                        //       CupertinoDatePicker(
                        //         backgroundColor: Colors.white,
                        //         initialDateTime: dateTime,
                        //         onDateTimeChanged: (DateTime newTime) {
                        //           setState(() =>dateTime = newTime);
                        //         },
                        //         use24hFormat: true,
                        //         mode: CupertinoDatePickerMode.date,
                        //       ),),
                        // ],
                        // ),
                        //   ],
                        // ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30, width: 30),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 30),
               SizedBox(
                width: 70,
                child: Text(
                  AppLocalizations.of(context).translate('note'),
                  style:const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _noteController,
                  decoration: InputDecoration(hintText: AppLocalizations.of(context).translate('more_details')),
                ),
              ),
              const SizedBox(width: 30),
            ],
          ),
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 30),
               SizedBox(
                width: 70,
                child: Text(
                  AppLocalizations.of(context).translate('expense'),
                  style:const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _moneyController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [CurrencyTextInputFormatter(locale: "vi")],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).translate('please_enter_the_amount');
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: '10.000 VND',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30, width: 30),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30, width: 30),
              Text(
                AppLocalizations.of(context).translate('category'),
                style:const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => activeCategory = index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
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
                          color: Colors.black12.withOpacity(0.05),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.01),
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
                                    AssetImage(categories[index]['icon']),
                                    color: Colors.black87,
                                    size: 40,
                                  ),
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context).translate(categories[index]['name']),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SpendingFirebase.addSpending(
                      Spending(
                        money: int.parse(_moneyController.text
                            .replaceAll(RegExp(r'[^0-9]'), '')),
                        note: _noteController.text,
                        type: activeCategory,
                        dateTime: dateTime,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(AppLocalizations.of(context).translate('save')),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
