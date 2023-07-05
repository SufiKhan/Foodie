import 'package:flutter/material.dart';
import 'package:workspace/Utils/AppColors.dart';
import 'package:workspace/Utils/Dimensions.dart';
import 'package:workspace/Widgets/app_icon.dart';
import 'package:workspace/Widgets/big_text.dart';
import 'package:workspace/Widgets/icon_text_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppColors.gradient),
        ),
        title: BigText(text: "Profile", color: Colors.white,),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            AppIcon(icon: Icons.person,
            iconColor: AppColors.mainColor3,
            iconSize: Dimensions.width45 * 3,),
            SizedBox(height: Dimensions.height30,),
            Expanded(child:SingleChildScrollView(
              child: Column(
                children: [
                  const IconTextWidget(icon: Icons.person,
                    text: "Sarfaraz",
                    iconColor: AppColors.mainColor3,
                    needBiggerIconSize: true,
                    needBiggerTextSize: true,),
                  SizedBox(height: Dimensions.height30,),
                  const IconTextWidget(icon: Icons.phone,
                    text: "34898893",
                    iconColor: AppColors.mainColor3,
                    needBiggerIconSize: true,
                    needBiggerTextSize: true,),
                  SizedBox(height: Dimensions.height30,),
                  const IconTextWidget(icon: Icons.email,
                    text: "ios.sarfaraz@gmail.com",
                    iconColor: AppColors.mainColor3,
                    needBiggerIconSize: true,
                    needBiggerTextSize: true,),
                  SizedBox(height: Dimensions.height30,),
                  const IconTextWidget(icon: Icons.location_pin,
                    text: "705, Anime building, 7 Border St, Tst",
                    iconColor: AppColors.mainColor3,
                    needBiggerIconSize: true,
                    needBiggerTextSize: true,),
                  SizedBox(height: Dimensions.height30 * 2,),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
