import 'package:flutter/material.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';

class ItemOnBoarding extends StatelessWidget {
  const ItemOnBoarding({Key? key, required this.item}) : super(key: key);
  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20),
          Text(
            //AppLocalizations.of(context).translate
            (item["title"]!),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            //AppLocalizations.of(context).translate
              (item["content"]!),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          const Spacer(),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black54)),
            child: Image.asset(
              item["image"]!,
              fit: BoxFit.fitHeight,
              height: MediaQuery.of(context).size.height - 300,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
