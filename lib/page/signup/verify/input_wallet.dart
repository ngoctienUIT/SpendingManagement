import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:spending_management/constants/app_styles.dart';
import 'package:spending_management/constants/function/on_will_pop.dart';
import 'package:spending_management/controls/spending_firebase.dart';
import 'package:spending_management/page/login/widget/custom_button.dart';
import 'package:spending_management/setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWalletPage extends StatefulWidget {
  const InputWalletPage({Key? key}) : super(key: key);

  @override
  State<InputWalletPage> createState() => _InputWalletPageState();
}

class _InputWalletPageState extends State<InputWalletPage> {
  final TextEditingController _moneyController = TextEditingController();
  DateTime? currentBackPressTime;

  @override
  void dispose() {
    _moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context).translate('wallet'),
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(context).translate(
                      'enter_monthly_spending_amount_you_want_manage'),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: _moneyController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[\\s0-9a-zA-Z]")),
                    CurrencyTextInputFormatter(locale: "vi")
                  ],
                  style: const TextStyle(fontSize: 20),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    hintStyle: AppStyles.p,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "1.000.000 VND",
                    contentPadding: const EdgeInsets.all(20),
                  ),
                ),
                const SizedBox(height: 30),
                customButton(
                  action: () async {
                    await SpendingFirebase.addWalletMoney(int.parse(
                        _moneyController.text
                            .replaceAll(RegExp(r'[^0-9]'), '')));
                    if (!mounted) return;
                    Navigator.pushReplacementNamed(context, '/main');
                  },
                  text: "OK",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
