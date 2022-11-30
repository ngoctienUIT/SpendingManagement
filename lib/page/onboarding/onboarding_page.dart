import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:spending_management/constants/function/on_will_pop.dart';
import '../../constants/app_colors.dart';
import '../../setting/localization/app_localizations.dart';
import 'onboarding_body.dart';
import 'package:flutter/material.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController();
  bool isLastPage = false;
  List<Map<String, String>> listPage = [
    {
      "image": "assets/images/",
      "title": "Trang chủ",
      "content": "Xem tổng kết chi tiêu và số dư còn lại hàng tháng"
    },
    {
      "image": "assets/images/",
      "title": "Lịch",
      "content": "Xem lại những chi tiêu theo lịch biểu"
    },
    {
      "image": "assets/images/",
      "title": "Báo cáo",
      "content": "Xem báo cáo chi tiêu và thu nhập của bạn qua biểu đồ"
    },
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 60),
          child: PageView.builder(
            controller: controller,
            itemCount: listPage.length,
            onPageChanged: (value) {
              setState(() => isLastPage = value == 2);
            },
            itemBuilder: (context, index) => itemOnboarding(listPage[index]),
          ),
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.buttonLogin,
          minimumSize: const Size.fromHeight(60),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: Text(
          AppLocalizations.of(context).translate('get_started'),
          style: const TextStyle(fontSize: 20),
        ),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => controller.jumpToPage(2),
              child: Text(
                AppLocalizations.of(context).translate('skip'),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                  spacing: 10,
                  dotWidth: 10,
                  dotHeight: 10,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.teal.shade700,
                ),
                onDotClicked: (index) => controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              child: Text(
                AppLocalizations.of(context).translate('next'),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
