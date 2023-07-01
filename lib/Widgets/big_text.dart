
import 'package:flutter/cupertino.dart';
import 'package:workspace/Utils/Dimensions.dart';

class BigText extends StatelessWidget {

  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  BigText({Key? key,
    this.color = const Color(0xFF332d2b),
    this.size=0,
    required this.text,
    this.overflow = TextOverflow.ellipsis}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontSize: size==0?Dimensions.font20 : size,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto'
      ),

    );
  }


}