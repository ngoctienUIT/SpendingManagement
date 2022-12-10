import 'dart:io';
import 'dart:math';
import 'package:spending_management/constants/function/loading_animation.dart';
import 'package:spending_management/constants/function/route_function.dart';
import 'package:spending_management/constants/list.dart';
import 'package:spending_management/controls/spending_firebase.dart';
import 'package:spending_management/models/spending.dart';
import 'package:spending_management/page/add_spending/widget/circle_text.dart';
import 'package:spending_management/page/edit_spending/edit_spending_page.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ViewSpendingPage extends StatefulWidget {
  const ViewSpendingPage({
    Key? key,
    required this.spending,
    this.delete,
    this.change,
  }) : super(key: key);
  final Spending spending;
  final Function(String id)? delete;
  final Function(Spending spending)? change;

  @override
  State<ViewSpendingPage> createState() => _ViewSpendingPageState();
}

class _ViewSpendingPageState extends State<ViewSpendingPage> {
  List<Color> colors = [];
  final numberFormat = NumberFormat.currency(locale: "vi_VI");
  ScreenshotController screenshotController = ScreenshotController();
  late Spending spending;

  @override
  void initState() {
    for (var _ in widget.spending.friends!) {
      colors.add(Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 1));
    }
    spending = widget.spending.copyWith();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await screenshotController
                  .capture(delay: const Duration(milliseconds: 10))
                  .then((image) async {
                if (image != null) {
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      await File('${directory.path}/image.png').create();
                  await imagePath.writeAsBytes(image);

                  await Share.shareFiles([imagePath.path]);
                }
              });
            },
            icon: const Icon(
              Icons.share,
              color: Color.fromRGBO(18, 114, 216, 1),
            ),
          ),
          IconButton(
            onPressed: () {
               Navigator.of(context).push(createRoute(
                 screen: EditSpendingPage(
                   spending: spending,
                   change: (spending, colors) async {
                     try {
                       spending.image = await FirebaseStorage.instance
                           .ref()
                           .child("spending/${spending.id}.png")
                           .getDownloadURL();
                     } catch (_) {}
                     if (widget.change != null) {
                       widget.change!(spending);
                     }
                     setState(() {
                       this.spending = spending;
                       this.colors = colors;
                     });
                   },
                ),
               ));
            },
            icon: const Icon(
              Icons.edit,
              color: Color.fromRGBO(231, 187, 18, 1),
            ),
          ),
          IconButton(
            onPressed: () async {
              await showConfirmDialog();
            },
            icon: const Icon(
              Icons.delete,
              color: Color.fromRGBO(255, 0, 24, 1),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Screenshot(
          controller: screenshotController,
          child: Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        listType[spending.type]["image"]!,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        spending.type == 41
                            ? spending.typeName!
                            : AppLocalizations.of(context)
                                .translate(listType[spending.type]["title"]!),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 60),
                      Text(
                        numberFormat.format(spending.money.abs()),
                        style: const TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  line(),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.calendar_month_rounded,
                          size: 30,
                          color: Color.fromRGBO(244, 131, 27, 1),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat("dd/MM/yyyy - HH:mm")
                            .format(spending.dateTime),
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  if (spending.note != null && spending.note!.isNotEmpty)
                    Row(
                      children: [
                        const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.edit_note_rounded,
                            size: 30,
                            color: Color.fromRGBO(221, 96, 0, 1),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          spending.note!,
                          maxLines: 10,
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  if (spending.location != null &&
                      spending.location!.isNotEmpty)
                    Row(
                      children: [
                        const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.location_on_outlined,
                            size: 30,
                            color: Color.fromRGBO(99, 195, 40, 1),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          spending.location!,
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  if (spending.friends != null && spending.friends!.isNotEmpty)
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 5),
                        addFriend(),
                        const SizedBox(height: 5),
                      ],
                    ),
                  if (spending.friends != null && spending.friends!.isNotEmpty)
                    const SizedBox(height: 10),
                  if (spending.image != null) Image.network(spending.image!)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addFriend() {
    return Row(
      children: [
        const SizedBox(
          height: 50,
          width: 50,
          child: Icon(
            Icons.people,
            color: Color.fromRGBO(202, 31, 52, 1),
            size: 30,
          ),
        ),
        const SizedBox(width: 10),
        if (spending.friends!.isNotEmpty)
          Expanded(
            child: Wrap(
              runSpacing: 5,
              spacing: 2,
              children: List.generate(spending.friends!.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        circleText(
                          text: spending.friends![index][0],
                          color: colors[index],
                        ),
                        const SizedBox(width: 10),
                        Text(
                          spending.friends![index],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          )
      ],
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

  Future showConfirmDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              AppLocalizations.of(context).translate('you_want_delete'),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    loadingAnimation(context);
                    await SpendingFirebase.deleteSpending(spending);
                    if (widget.delete != null) {
                      widget.delete!(spending.id!);
                    }
                    if (!mounted) return;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context).translate('cancel')),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
