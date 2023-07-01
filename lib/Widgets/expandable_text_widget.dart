import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspace/Utils/AppColors.dart';
import 'package:workspace/Widgets/small_text.dart';

import '../Utils/Dimensions.dart';
import 'big_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {

  late String collapsedText;
  late String expandedText;
  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight/5.63;

  @override
  void initState() {
    super.initState();
    if(widget.text.length > textHeight) {
      collapsedText = widget.text.substring(0, textHeight.toInt());
      expandedText = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    } else {
      collapsedText = widget.text;
      expandedText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: expandedText.isEmpty ? SmallText(text: collapsedText, size: Dimensions.font16, color: AppColors.paraColor,) : Column(
        children: [
          SmallText(size: Dimensions.font16,
              text: hiddenText ? ("$collapsedText...") : (collapsedText + expandedText),
            color: AppColors.paraColor,
            height: 1.8,
          ),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: hiddenText? "Show more" : "Show less", color: AppColors.mainColor,),
                Icon(hiddenText ? Icons.arrow_drop_down: Icons.arrow_drop_up, color: AppColors.mainColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
