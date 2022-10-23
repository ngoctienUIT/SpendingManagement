import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spending_management/constants/function/list_categories.dart';

class InputSpending extends StatefulWidget {
  const InputSpending({Key? key}) : super(key: key);

  @override
  State<InputSpending> createState() => _InputSpendingState();
}

class _InputSpendingState extends State<InputSpending> {
  DateTime dateTime = DateTime.now();
  int activeCategory = 0;
  Color primary = const Color(0xFFFF3378);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 30, width: 30),
            const SizedBox(
              height: 30,
              width: 70,
              child: Text(
                "Ngày",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: CupertinoButton(
                color: Colors.black12,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Text(
                  "${DateFormat("dd/MM/yyyy").format(dateTime)}(${dateTime.weekday})",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
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
          children: const [
            SizedBox(height: 30, width: 30),
            SizedBox(
              width: 70,
              height: 30,
              child: Text(
                "Ghi chú",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(hintText: 'Nhập ghi chú'),
              ),
            ),
            SizedBox(height: 30, width: 30),
          ],
        ),
        Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SizedBox(height: 30, width: 30),
            SizedBox(
              width: 70,
              height: 30,
              child: Text(
                "Tiền chi",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30, width: 30),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(height: 30, width: 30),
            Text(
              "Danh mục",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                              categories[index]['name'],
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
              onPressed: () {},
              child: const Text("Nhập khoản chi"),
            ),
          ),
        ]),
      ],
    );
  }
}
