import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputMoney extends StatelessWidget {
  const InputMoney({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 100,
      // color: Colors.white,
      child: TextFormField(
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[\\s0-9a-zA-Z]")),
          CurrencyTextInputFormatter(locale: "vi")
        ],
        textAlign: TextAlign.right,
        style: const TextStyle(fontSize: 20),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          border: InputBorder.none,
          hintText: "100.000 VND",
          hintStyle: const TextStyle(fontSize: 20),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
