import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/Utils/AppColors.dart';
import 'package:workspace/Widgets/FRadioTile.dart';
import 'package:workspace/Widgets/app_icon.dart';
import 'package:workspace/Widgets/big_text.dart';
import 'package:workspace/Widgets/small_text.dart';
import 'package:workspace/controllers/CartController.dart';
import 'package:workspace/helper/RouteHelper.dart';
import 'package:workspace/models/CartModel.dart';
import 'package:workspace/models/Recommended.dart';
import 'package:workspace/page/Tabbar/TabbarPage.dart';
import 'package:workspace/page/food/RecommendedFoodDetailPage.dart';

import '../../Utils/AppConstants.dart';
import '../../Utils/Dimensions.dart';
import 'CartConfirmationPage.dart';

typedef OrderConfirmedCallBack = void Function();

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return controller.items.isEmpty ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset(
            "assets/image/empty_cart.png"
        ),
          SizedBox(height: Dimensions.height20,),
          BigText(text: "Your cart is empty, order now!", size: Dimensions.font26,)
        ]
      ):
       Scaffold(
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
                    child: BigText(text: "Cart",
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
                            itemCount: controller.getItems().length,
                            itemBuilder: (_, index) {
                              return _buildCartList(index, controller.getItems()[index], controller);
                            });
                      })
                  ),
                ))
          ],
        ),
        bottomNavigationBar: Container(
        height: Dimensions.bottomNavigationBarHeight,
        padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.height20, right: Dimensions.height20),
        decoration: BoxDecoration(
          color: AppColors.buttonBoxDecorColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20),
            topRight: Radius.circular(Dimensions.radius20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width20,
                  bottom: Dimensions.height20,
                  right: Dimensions.width20
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20)
              ),
              child: Row(
                children: [
                  SizedBox(width: Dimensions.width10/2,),
                  BigText(text: "\$ ${controller.totalAmount}"),
                  SizedBox(width: Dimensions.width10/2,),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (controller.items.isNotEmpty) {
                  showModalBottomSheet(context: context, builder: (BuildContext ctx) {
                      return CartConfirmationPage(callBack:() {
                          controller.checkOut();
                          Get.toNamed(RouteHelper.getInitial(1));
                      });
                  });
                }
              },
              child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.height20, right: Dimensions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    gradient: AppColors.gradient,
                  ),
                  child: BigText(text: "Check out", color: Colors.white,)
              ),
            )
          ],
        ),
      ),
      );
    });

  }

  Widget _buildCartList(int index, CartItem model, CartController controller) {
    return Container(
        height: 100,
        width: double.maxFinite,
        child: GestureDetector(
          onTap: () {
            RouteHelper.presentDetailPage(model.itemIndexInList!, model.itemType);
          },
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            AppConstants.BASE_URL+"/uploads/"+model.img!
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
                    SmallText(text: ""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(text: "\$ ${model.price!}", color: Colors.brown,),
                        Container(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap:() {
                                  controller.updateCartPageList(model, model.quantity!-1);
                                },
                                child: Icon(Icons.remove, color: Colors.red,),
                              ),
                              SizedBox(width: Dimensions.width10/2,),
                              BigText(text: model.quantity!.toString()),
                              SizedBox(width: Dimensions.width10/2,),
                              GestureDetector(
                                onTap:() {

                                  controller.updateCartPageList(model, model.quantity!+1);
                                },
                                child: Icon(Icons.add, color: Colors.green,),
                              )],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}

