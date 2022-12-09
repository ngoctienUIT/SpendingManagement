import 'dart:math';
import 'package:spending_management/constants/app_styles.dart';
import 'package:spending_management/page/add_spending/widget/circle_text.dart';
import 'package:spending_management/page/add_spending/widget/remove_icon.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({
    Key? key,
    required this.friends,
    required this.action,
    required this.colors,
  }) : super(key: key);
  final List<String> friends;
  final Function(List<String> friends, List<Color> colors) action;
  final List<Color> colors;

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final _friend = TextEditingController();
  List<String> friends = [];
  final List<Color> colors = [];

  @override
  void initState() {
    friends.addAll(widget.friends);
    colors.addAll(widget.colors);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context).translate('add_friends')),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          TextButton(
            onPressed: () {
              widget.action(friends, colors);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context).translate('done')),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: _friend,
                style: AppStyles.p,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      friends.add(value.trim());
                      colors.add(Color.fromRGBO(Random().nextInt(255),
                          Random().nextInt(255), Random().nextInt(255), 1));
                      _friend.text = "";
                    });
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:
                      AppLocalizations.of(context).translate('add_friends'),
                  hintStyle: AppStyles.p,
                ),
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.5),
            if (friends.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          circleText(
                            text: friends[index][0],
                            color: colors[index],
                          ),
                          const SizedBox(width: 10),
                          Text(
                            friends[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          removeIcon(action: () {
                            setState(() {
                              friends.removeAt(index);
                            });
                          })
                        ],
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
