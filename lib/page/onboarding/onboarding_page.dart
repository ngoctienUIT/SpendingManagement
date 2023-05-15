import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/app_colors.dart';
import '../../constants/function/on_will_pop.dart';
import '../../setting/localization/app_localizations.dart';
import 'onboarding_body.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;
  DateTime? currentBackPressTime;
  List<Map<String, String>> listPage = [
    {
      "image": "assets/intro/home.jpg",
      "title": "home",
      "content": "view_monthly_spending_summary_and_remaining_balance"
    },
    {
      "image": "assets/intro/calendar.jpg",
      "title": "calendar",
      "content": "review_your_scheduled_expenses"
    },
    {
      "image": "assets/intro/add.jpg",
      "title": "add_spending",
      "content": "add_and_edit_your_daily_spending"
    },
    {
      "image": "assets/intro/share.jpg",
      "title": "share",
      "content": "share_your_spending_with_friends"
    },
    {
      "image": "assets/intro/search.jpg",
      "title": "search",
      "content": "search_for_your_expenses"
    },
    {
      "image": "assets/intro/analytic.jpg",
      "title": "statistical",
      "content": "view_your_spending_and_income_reports_through_graphs"
    },
    {
      "image": "assets/intro/profile.jpg",
      "title": "account",
      "content": "edit_personal_information_and_other_settings"
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
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(bottom: 60),
            child: PageView.builder(
              controller: controller,
              itemCount: listPage.length,
              onPageChanged: (value) {
                setState(() => isLastPage = value == 6);
              },
              itemBuilder: (context, index) => ItemOnBoarding(
                item: listPage[index],
              ),
            ),
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
                    onPressed: () => controller.jumpToPage(6),
                    child: Text(
                      AppLocalizations.of(context).translate('skip'),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 7,
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
