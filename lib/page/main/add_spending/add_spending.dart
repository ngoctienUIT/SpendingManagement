import 'dart:io';
import 'package:spending_management/constants/app_styles.dart';
import 'package:spending_management/constants/function/loading_animation.dart';
import 'package:spending_management/constants/function/pick_function.dart';
import 'package:spending_management/constants/function/route_function.dart';
import 'package:spending_management/page/main/add_spending/widget/add_friend.dart';
import 'package:spending_management/page/main/add_spending/widget/input_money.dart';
import 'package:spending_management/page/main/add_spending/widget/pick_image_widget.dart';
import 'package:spending_management/constants/list.dart';
import 'package:spending_management/controls/spending_firebase.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/main/add_spending/choose_type.dart';
import 'package:spending_management/page/main/add_spending/widget/input_spending.dart';
import 'package:spending_management/page/main/add_spending/widget/item_spending.dart';
import 'package:spending_management/page/main/add_spending/widget/more_button.dart';
import 'package:spending_management/page/main/add_spending/widget/remove_icon.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddSpendingPage extends StatefulWidget {
  const AddSpendingPage({Key? key}) : super(key: key);

  @override
  State<AddSpendingPage> createState() => _AddSpendingPageState();
}

class _AddSpendingPageState extends State<AddSpendingPage> {
  final _money = TextEditingController();
  final _note = TextEditingController();
  final _location = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int? type;
  XFile? image;
  bool more = false;
  String? typeName;
  int coefficient = 1;
  List<String> friends = [];
  List<Color> colors = [];

  @override
  void dispose() {
    _money.dispose();
    _note.dispose();
    _location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(AppLocalizations.of(context).translate('add_spending')),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await addingSpending();
            },
            child: Text(
              AppLocalizations.of(context).translate('save'),
              style: AppStyles.p,
            ),
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.close_outlined, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: InputMoney(controller: _money),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addSpending(),
            if (more) moreFunction(),
            MoreButton(
              action: () => setState(() => more = !more),
              more: more,
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Widget addSpending() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    type == null
                        ? "assets/icons/question_mark.png"
                        : listType[type!]["image"]!,
                    width: 35,
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context).push(
                          createRoute(
                            screen: ChooseType(
                              action: (index, coefficient, name) {
                                setState(() {
                                  type = index;
                                  typeName = name;
                                  this.coefficient = coefficient;
                                });
                              },
                            ),
                            begin: const Offset(1, 0),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            type == null
                                ? AppLocalizations.of(context).translate('type')
                                : (type == 41
                                ? typeName!
                                : AppLocalizations.of(context)
                                .translate(listType[type!]["title"]!)),
                            style: AppStyles.p,
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              line(),
              itemSpending(
                color: const Color.fromRGBO(244, 131, 27, 1),
                icon: Icons.calendar_month_rounded,
                text: DateFormat("dd/MM/yyyy").format(selectedDate),
                action: () async {
                  var day = await selectDate(
                      context: context, initialDate: selectedDate);
                  if (day != null && day != selectedDate) {
                    setState(() => selectedDate = day);
                  }
                },
              ),
              line(),
              itemSpending(
                color: const Color.fromRGBO(241, 186, 5, 1),
                icon: Icons.access_time_rounded,
                text:
                "${selectedTime.hour.toString().padLeft(2, "0")}:${selectedTime.minute.toString().padLeft(2, "0")}",
                action: () async {
                  var time = await selectTime(
                      context: context, initialTime: selectedTime);
                  if (time != null && time != selectedTime) {
                    setState(() => selectedTime = time);
                  }
                },
              ),
              line(),
              inputSpending(
                icon: Icons.edit_note_rounded,
                color: const Color.fromRGBO(221, 96, 0, 1),
                controller: _note,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                hintText: AppLocalizations.of(context).translate('note'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget moreFunction() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  inputSpending(
                    icon: Icons.location_on_outlined,
                    color: const Color.fromRGBO(99, 195, 40, 1),
                    controller: _location,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.done,
                    hintText:
                    AppLocalizations.of(context).translate('location'),
                  ),
                  line(),
                  const SizedBox(height: 5),
                  AddFriend(
                    friends: friends,
                    colors: colors,
                    add: (friends, colors) {
                      setState(() {
                        this.colors = colors;
                        this.friends = friends;
                      });
                    },
                    remove: (index) => setState(() {
                      friends.removeAt(index);
                      colors.removeAt(index);
                    }),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          imageWidget(),
        ],
      ),
    );
  }

  Widget imageWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: image == null
          ? pickImageWidget(image: (file) {
        if (file != null) {
          setState(() => image = file);
        }
      })
          : Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.file(
              File(image!.path),
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: removeIcon(
              background: Colors.red.withOpacity(0.8),
              color: Colors.white,
              action: () => setState(() => image = null),
            ),
          )
        ],
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

  Future addingSpending() async {
    String moneyString = _money.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (type != null &&
        moneyString.isNotEmpty &&
        moneyString.compareTo("0") != 0) {
      int money = int.parse(moneyString);
      Spending spending = Spending(
        money: type == 41
            ? coefficient * money
            : ([29, 30, 34, 36, 37, 40].contains(type!) ? 1 : -1) * money,
        type: type!,
        typeName: typeName != null ? typeName!.trim() : typeName,
        dateTime: DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        ),
        note: _note.text.trim(),
        image: image != null ? image!.path : null,
        location: _location.text.trim(),
        friends: friends,
      );
      loadingAnimation(context);
      await SpendingFirebase.addSpending(spending);
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.pop(context);
    } else if (type == null) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('please_select_type'));
    } else {
      Fluttertoast.showToast(
        msg:
        AppLocalizations.of(context).translate('please_enter_valid_amount'),
      );
    }
  }
}