import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../Utils/AppColors.dart';
import '../../Utils/AppConstants.dart';
import '../../Utils/Dimensions.dart';
import '../../Widgets/app_icon.dart';
import '../../Widgets/big_text.dart';
import '../../Widgets/small_text.dart';
import '../../controllers/CartController.dart';
import '../../models/CartModel.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return controller.historyList.isEmpty ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigText(
              text: "You have no order history", size: Dimensions.font26,)
          ]
      ): Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: Dimensions.height20*5,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: BigText(text: "Orders",
                      color: AppColors.mainColor,
                      size: 30,),
                  ),
                )
            ),
            Positioned(
                top: Dimensions.height20 * 5,// because we need to set it below the nav buttons
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (controller) {
                        return ListView.builder(
                            itemCount: controller.historyList.length,
                            itemBuilder: (_, index) {
                              return _buildCartList(index, controller.historyList[index], controller);
                            });
                      })
                  ),
                ))
          ],
        ),
      );
    });
  }

  Widget _buildCartList(int index, CartItem model, CartController controller) {
    return SizedBox(
        height: 100,
        width: double.maxFinite,
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "${AppConstants.BASE_URL}/uploads/${model.img!}"
                      )
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius20)
              ),
            ),
            SizedBox(width: Dimensions.width10,),
            Expanded(child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BigText(text: model.name!),
                  SmallText(text: "\$ ${model.price!} x ${model.quantity}",
                      color: Colors.brown,
                  size: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(text: "${model.time!.substring(0, 16)}",
                          color: AppColors.titleColor),
                      BigText(text: "\$ ${model.price! * model.quantity!}", color: AppColors.mainBlackColor,),
                    ],
                  ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: AppColors.gradient,
                    ),
                  )
                ],
              ),
            )),

          ],
        ),
    );
  }
}
