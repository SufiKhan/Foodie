import 'package:flutter/cupertino.dart';
import 'package:workspace/Utils/AppColors.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  const AppIcon({Key? key,
    required this.icon,
    this.backgroundColor = AppColors.buttonBackgroundColor,
    this.iconColor = AppColors.titleColor,
    this.size=40,
    this.iconSize=16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(size/2),
        color: backgroundColor
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
