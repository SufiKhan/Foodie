import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppColors {

  static const Color mainColor3 = Color(0xFF162194);
  static const Color mainColor2 = Color(0xFFae34eb);
  static const Color mainColor = Color(0xFF9a10b5);
  static const Color textColor = Color(0xFFccc7c5);
  static const Color mainBlackColor = Color(0xFF332d2b);
  static const Color iconColor1 =  Color(0xFFffd28d);
  static const Color iconColor2 =  Color(0xFFfcab88);
  static const Color paraColor =  Color(0xFF8f837f);
  static const Color buttonBackgroundColor=  Color(0xFFf7f6f9);
  static const Color signColor =  Color(0xFFa9a29f);
  static const Color titleColor =  Color(0xFF5c524f);
  static const Color yellowColor =  Color(0xFFffd379);
  static const Color buttonBoxDecorColor = Color(0xFFf2f2f2);

  static LinearGradient get gradient {
    return const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [AppColors.mainColor,
          AppColors.mainColor2,
          AppColors.mainColor3]
    );
  }
}