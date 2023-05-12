import '../../../../constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget tabBarChart({required TabController controller}) {
  return Container(
    height: 45,
    width: 110,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(242, 243, 247, 1),
      borderRadius: BorderRadius.circular(90),
    ),
    child: TabBar(
        controller: controller,
        labelColor: const Color(0xff2c4260),
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        unselectedLabelColor: const Color.fromRGBO(45, 216, 198, 1),
        unselectedLabelStyle: AppStyles.p,
        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(5),
        indicator: const BoxDecoration(
          color: Color.fromRGBO(45, 216, 198, 1),
          shape: BoxShape.circle,
        ),
        tabs: const [
          Icon(FontAwesomeIcons.chartColumn),
          Icon(FontAwesomeIcons.chartPie),
        ]),
  );
}
