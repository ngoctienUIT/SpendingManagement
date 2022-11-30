import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future selectTime({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
      child: child!,
    ),
  );
  return picked;
}

Future<DateTime?> selectDate({
  required BuildContext context,
  required DateTime initialDate,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
  return picked;
}

Future<XFile?> pickImage(bool check) async {
  try {
    final image = await ImagePicker()
        .pickImage(source: check ? ImageSource.gallery : ImageSource.camera);
    return image;
  } on PlatformException catch (_) {}
  return null;
}
