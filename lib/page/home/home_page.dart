import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspace/Utils/Dimensions.dart';
import 'package:workspace/Widgets/big_text.dart';
import 'package:workspace/Widgets/small_text.dart';
import 'package:workspace/controllers/PopularProductController.dart';
import 'package:workspace/controllers/RecommendedFoodController.dart';
import '../../Utils/AppColors.dart';
import '../../Utils/AppConstants.dart';
import '../../Widgets/icon_text_widget.dart';
import '../../helper/RouteHelper.dart';
import '../../models/Recommended.dart';
import 'home_page_body.dart';


class HomePage extends StatefulWidget {
  
  @override
  _HomePagePageState createState() => _HomePagePageState();
  
}
class _HomePagePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      Column(
        children: [
          // header
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(
                    children: [
                      BigText(text: "HONG KONG", color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: "Hong Kong", color: AppColors.mainBlackColor,),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )

                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        gradient: AppColors.gradient
                      ),
                      child: Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24),
                    ),
                  )
                ],
              ),
            ),
          ),
          // body
          Expanded(child: SingleChildScrollView(
            child: HomePageBody(),
          ),)
        ],
      ),
    );
  }


}