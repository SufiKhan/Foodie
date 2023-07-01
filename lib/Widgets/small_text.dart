import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {

  final Color? color;
  final String text;
  double size;
  double height;
  int maxLines;

  SmallText({Key? key,
    this.color = const Color(0xFF5c524f),
    this.size=12,
    this.height = 1.2,
    this.maxLines=0,
    required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      text,
      maxLines: maxLines ==0 ? double.maxFinite.toInt():maxLines,
      // maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontSize: size,
          height: height
      ),
    );
  }


}