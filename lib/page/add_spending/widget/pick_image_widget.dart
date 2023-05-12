import '../../../constants/function/pick_function.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget pickImageWidget({required Function(XFile? file) image}) {
  return IntrinsicHeight(
    child: Row(
      children: [
        Expanded(
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () async {
              var file = await pickImage(true);
              image(file);
            },
            icon: const Icon(Icons.image, size: 30),
          ),
        ),
        const VerticalDivider(
          color: Colors.black54,
          thickness: 1,
          indent: 5,
          endIndent: 5,
        ),
        Expanded(
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () async {
              var file = await pickImage(false);
              image(file);
            },
            icon: const Icon(Icons.camera_alt, size: 30),
          ),
        ),
      ],
    ),
  );
}
