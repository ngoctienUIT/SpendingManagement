import 'package:flutter/material.dart';
import 'package:spending_management/constants/function/on_will_pop.dart';
import 'onboarding_body.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  DateTime? currentBackPressTime;

  final List<Widget> _pages = [
    const OnboardingBody(
      title: "keep save",
      description: "accessToken",
      image: "assets/images/anh11.jpg",
    ),
    const OnboardingBody(
      title: "keep save",
      description: "accessToken",
      image: "assets/images/anh1.jpg",
    ),
    const OnboardingBody(
      title: "keep save",
      description: "accessToken",
      image: "assets/images/anh22.png",
    ),
  ];

  onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => onWillPop(
          action: (now) => currentBackPressTime = now,
          currentBackPressTime: currentBackPressTime,
        ),
        child: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return _pages[index];
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    _pages.length,
                    (int index) {
                      return AnimatedContainer(
                        duration: const Duration(microseconds: 300),
                        height: 10,
                        width: (index == currentPage) ? 30 : 10,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == currentPage)
                              ? Colors.blue
                              : Colors.blue.withOpacity(0.5),
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOutQuint,
                    );
                    if (currentPage == 2) {
                      Navigator.pushReplacementNamed(context, "/login");
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 70,
                    alignment: Alignment.center,
                    width: (currentPage == (_pages.length - 1)) ? 200 : 70,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: (currentPage == (_pages.length - 1))
                        ? const Text(
                            "get stated",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        : const Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                            size: 50,
                          ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            )
          ],
        ),
      ),
    );
  }
}
