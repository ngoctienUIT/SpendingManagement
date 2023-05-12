import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class ItemFilter extends StatelessWidget {
  const ItemFilter({
    Key? key,
    required this.text,
    required this.action,
    required this.list,
    required this.value,
    this.content,
  }) : super(key: key);
  final String text;
  final Function(int) action;
  final List<String> list;
  final String value;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  hint: Center(
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                  underline: const SizedBox.shrink(),
                  icon: const SizedBox.shrink(),
                  isExpanded: true,
                  // value: value,
                  items: list.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).translate(e),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      action(list.indexOf(value));
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
