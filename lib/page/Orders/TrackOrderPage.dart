import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workspace/Utils/Dimensions.dart';
import 'package:workspace/Widgets/big_text.dart';
import 'package:workspace/Widgets/small_text.dart';
import 'package:workspace/models/CartModel.dart';

import '../../Utils/AppColors.dart';
import '../../Utils/AppConstants.dart';
import '../../Widgets/app_icon.dart';

class TrackOrderPage extends StatelessWidget {

  const TrackOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartItem item = Get.arguments;
    DateFormat format = DateFormat("yyyy-MM-dd hh:mm");
    DateTime modelDate = format.parse(item.time!);
    modelDate.add(const Duration(minutes: 30));
    final estTime = format.format(modelDate);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: Dimensions.height45, left: Dimensions.width10, right: Dimensions.width10),
          child: Column(
            children: [
              Row(
                children:[
                  Padding(padding: EdgeInsets.only(left: Dimensions.width20)),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const AppIcon(icon: Icons.close_sharp,
                      backgroundColor: AppColors.titleColor,
                      iconColor: Colors.white,) ,
                  )
                ] ,
              ),
              Container(
                  height: Dimensions.height45*6,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(
                      "${AppConstants.BASE_URL}/uploads/${item.img!}",
                    ),fit: BoxFit.cover
                    )
                  ),
              ),
              Container(
                height: 1,
                width: Dimensions.screenWidth,
                color: AppColors.mainColor,
              ),
              SizedBox(height: Dimensions.height20,),
              BigText(text: "Delivery time is $estTime",
                size: Dimensions.font20,
                color: Colors.black,
              ),
              SizedBox(height: Dimensions.height20,),
              BigText(text: "Your order is on the way..",
                size: Dimensions.font20,
                color: Colors.black,
              ),
              SizedBox(height: Dimensions.height20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(text: "${item.name!} x ${item.quantity}"),
                  BigText(text: "\$${item.price! * item.quantity!}")
                ],
              ),
              SizedBox(height: Dimensions.height20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(text: "Delivery fee"),
                  SmallText(text: "\$20")
                ],
              ),
              SizedBox(height: Dimensions.height10,),
              Container(
                height: 1,
                width: Dimensions.screenWidth,
                color: AppColors.mainBlackColor,
              ),
              SizedBox(height: Dimensions.height10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(text: "Total"),
                  BigText(text: "\$${item.price! * item.quantity! + 20}")
                ],
              ),
              SizedBox(height: Dimensions.height20,),
              Container(
                child: BigText(
                  text: "Address: 705, Anime building, 7 Border St, Tst",
                  color: AppColors.mainColor,
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              Container(
                height: Dimensions.height45,
                width: Dimensions.width45 * 5,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20)
                ),
                child: Center(
                  child: SmallText(
                    text: "Change Address",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
