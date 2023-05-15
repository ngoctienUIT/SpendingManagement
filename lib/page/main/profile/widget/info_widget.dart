import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spending_management/constants/function/extension.dart';

import '../../../../models/user.dart';
import '../../../../setting/localization/app_localizations.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat.currency(locale: "vi_VI");

    return Column(
      children: [
        Material(
          elevation: 2,
          child: Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            width: double.infinity,
            height: 55,
            child: Center(
              child: user != null
                  ? Text(
                      user!.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : loadingInfo(width: Random().nextInt(50) + 150, height: 30),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ClipOval(
          child: user != null
              ? CachedNetworkImage(
                  imageUrl: user!.avatar,
                  width: 150,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => loadingInfo(
                    width: 150,
                    height: 150,
                    radius: 90,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : loadingInfo(width: 150, height: 150, radius: 90),
        ),
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context).translate('monthly_money').capitalize(),
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        user != null
            ? Text(
                numberFormat.format(user!.money),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            : loadingInfo(width: Random().nextInt(50) + 150, height: 30),
      ],
    );
  }

  Widget loadingInfo(
      {required double width, required double height, double radius = 5}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
