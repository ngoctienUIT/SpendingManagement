import 'package:flutter/material.dart';

class OnboardingBody extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingBody({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: width * 0.6),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              description,
              style: const TextStyle(
                  height: 1.5,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.7),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
