import 'package:flutter/material.dart';

class GlobalVariables {
  static final Color blueColor = Color(0xff2b9ed4);
  static final Color blackColor = Color(0xff19191b);
  static final Color greyColor = Color(0xff8f8f8f);
  static final Color userCircleBackground = Color(0xff2b2b33);
  static final Color onlineDotColor = Color(0xff46dc64);

  static final Color gradientColorStart = Color(4289235947);
  static final Color gradientColorEnd = Color(4294495980);

  // static final Color senderColor = Color(0xffcea2fd);
  // static final Color receiverColor = Color(0xffC0C0C0);

  static final Gradient fabGradient = LinearGradient(
      colors: [gradientColorStart, gradientColorEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
