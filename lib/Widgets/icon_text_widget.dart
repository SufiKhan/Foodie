import 'package:flutter/cupertino.dart';
import 'package:workspace/Utils/Dimensions.dart';
import 'package:workspace/Widgets/small_text.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final bool needBiggerIconSize;
  final bool needBiggerTextSize;

  const IconTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    this.needBiggerIconSize=false,
    this.needBiggerTextSize=false}): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Icon(icon, color: iconColor,
          size: !needBiggerIconSize ? Dimensions.iconSize24: Dimensions.iconSize16 * 2,),
        SizedBox(width: Dimensions.width5),
        SmallText(text: text, size: !needBiggerTextSize? Dimensions.font16 : Dimensions.font20,)
      ],
    );
  }

}