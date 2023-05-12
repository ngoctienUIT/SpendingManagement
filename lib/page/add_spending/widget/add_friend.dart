import '../../../constants/function/route_function.dart';
import '../../../page/add_spending/add_friend_page.dart';
import '../../../page/add_spending/widget/circle_text.dart';
import '../../../page/add_spending/widget/remove_icon.dart';
import '../../../setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({
    Key? key,
    required this.friends,
    required this.colors,
    required this.add,
    required this.remove,
  }) : super(key: key);
  final List<String> friends;
  final List<Color> colors;
  final Function(List<String> friends, List<Color> colors) add;
  final Function(int index) remove;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).push(
          createRoute(
            screen: AddFriendPage(
              friends: friends,
              colors: colors,
              action: (friends, colors) => add(friends, colors),
            ),
            begin: const Offset(1, 0),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(
                  Icons.people,
                  color: Color.fromRGBO(202, 31, 52, 1),
                  size: 30,
                ),
                const SizedBox(width: 10),
                friends.isEmpty
                    ? Text(
                  AppLocalizations.of(context).translate('friend'),
                  style:
                  const TextStyle(fontSize: 16, color: Colors.grey),
                )
                    : Expanded(
                  child: Wrap(
                    runSpacing: 5,
                    spacing: 2,
                    children: List.generate(friends.length, (index) {
                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 5),
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
                                text: friends[index][0],
                                color: colors[index],
                              ),
                              const SizedBox(width: 10),
                              Text(
                                friends[index],
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: 5),
                              removeIcon(action: () => remove(index)),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
