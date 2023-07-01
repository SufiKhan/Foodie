import 'package:flutter/cupertino.dart';
import 'package:workspace/Utils/Dimensions.dart';
import 'package:workspace/Widgets/small_text.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const IconTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor}): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.iconSize24,),
        const SizedBox(width: 5),
        SmallText(text: text)
      ],
    );
  }

}