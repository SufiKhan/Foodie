import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspace/Widgets/small_text.dart';

import '../Utils/AppColors.dart';
import '../Utils/Dimensions.dart';
import 'big_text.dart';
import 'icon_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double fontSize;
  const AppColumn({Key? key,
    required this.text,
    this.fontSize = 26}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: fontSize,),
        // ratings
        SizedBox(height: Dimensions.height5),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return const Icon(Icons.star, color: AppColors.mainColor);
              }),
            ),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "4.5"),
            SizedBox(width: Dimensions.width10),
            SmallText(text: "133"),
            SizedBox(width: Dimensions.width5),
            SmallText(text: "comments")
          ],
        ),
        SizedBox(height: Dimensions.height15),
        // time and distance
         const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconTextWidget(icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconTextWidget(icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.mainColor),
            IconTextWidget(icon: Icons.access_time_rounded,
                text: "22min",
                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
