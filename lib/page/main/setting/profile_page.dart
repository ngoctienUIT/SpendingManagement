import 'package:flutter/material.dart';
import 'package:spending_management/page/main/setting/setting_page.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';

class SettingProfile extends StatefulWidget {
  const SettingProfile({Key? key}) : super(key: key);

  @override
  State<SettingProfile> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('profile'), style:const TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.bold),),
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
            children: [
              Text(
                AppLocalizations.of(context).translate('profile'),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
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
