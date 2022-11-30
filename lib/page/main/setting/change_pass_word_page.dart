import 'package:flutter/material.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';

class ChangePassWord extends StatefulWidget {
  const ChangePassWord({Key? key}) : super(key: key);

  @override
  State<ChangePassWord> createState() => _ChangePassWord();
}

class _ChangePassWord extends State<ChangePassWord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('change'),
          style: const TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            header(),
            const SizedBox(height: 20),
            Expanded(child: body()),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                "doi mat khau",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget body() {
    return const Scaffold();
  }
}
