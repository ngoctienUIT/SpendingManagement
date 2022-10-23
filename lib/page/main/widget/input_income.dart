import 'package:flutter/material.dart';

class InputIncome extends StatelessWidget {
  const InputIncome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TextField(
          decoration: InputDecoration(
            hintText: 'Personal Note',
          ),
        ),
      ],
    );
  }
}
