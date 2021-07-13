import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/constants/onboard_page_data.dart';
import 'package:teams_clone/provider/color_provider.dart';

import 'components/onboard_page.dart';
import 'components/page_view_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProvider = Provider.of<ColorProvider>(context);

    return Stack(
      children: <Widget>[
        PageView.builder(
          controller: pageController,
          itemCount: onboardData.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return OnboardPage(
              pageController: pageController,
              pageModel: onboardData[index],
            );
          },
        ),
        Positioned(
          top: 50,
          left: 32,
          child: Text(
            'Teams Clone',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: colorProvider.color,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0, left: 40),
            child: PageViewIndicator(
              controller: pageController,
              itemCount: onboardData.length,
              color: colorProvider.color,
            ),
          ),
        )
      ],
    );
  }
}
