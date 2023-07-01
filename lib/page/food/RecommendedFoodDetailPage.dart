import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/Utils/AppColors.dart';
import 'package:workspace/Utils/AppConstants.dart';
import 'package:workspace/Utils/Dimensions.dart';
import 'package:workspace/Widgets/app_column.dart';
import 'package:workspace/Widgets/app_icon.dart';
import 'package:workspace/controllers/PopularProductController.dart';
import 'package:workspace/controllers/RecommendedFoodController.dart';
import 'package:workspace/controllers/TabbarController.dart';
import 'package:workspace/helper/RouteHelper.dart';

import '../../Widgets/big_text.dart';
import '../../Widgets/small_text.dart';
import '../../controllers/CartController.dart';
import '../../models/CartModel.dart';

class RecommendedFoodDetailPage extends StatelessWidget {
  final int index;
  final ItemType itemType;
  const RecommendedFoodDetailPage({Key? key, required this.index, required this.itemType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PopularProductController controller =
        Get.find<PopularProductController>();
    if (itemType == ItemType.popular) {
      CartItem model = controller.popularProductList[index];
      controller.init(Get.find<CartController>(), model.id!);
    } else {
      CartItem model = controller.recommendedFood[index];
      controller.init(Get.find<CartController>(), model.id!);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<PopularProductController>(builder: (controller) {
        CartItem model;
        switch (itemType) {
          case ItemType.popular: model = controller.popularProductList[index];
          case ItemType.recommended: model = controller.recommendedFood[index];
        }
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: Dimensions.detailPageSliverBarHeight,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const AppIcon(icon: Icons.close_sharp,
                      backgroundColor: AppColors.titleColor,
                    iconColor: Colors.white,),
                  ),
                  controller.getTotalItem(model.id!) > 0
                      ? GestureDetector(
                          onTap: () {
                            // tabbarController.changeTab(2);
                            Get.toNamed(RouteHelper.getInitial(2));
                          },
                          child: Badge(
                              largeSize: 20,
                              backgroundColor: AppColors.mainColor,
                              label: BigText(
                                text: controller
                                    .getTotalItem(model.id!)
                                    .toString(),
                                size: 16,
                                color: Colors.white,
                              ),
                              child: const Card(
                                  child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.shopping_cart_outlined),
                              ))),
                        )
                      : const AppIcon(
                          icon: Icons.shopping_cart_outlined,
                          backgroundColor: AppColors.titleColor,
                          iconColor: Colors.white,
                        )
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(Dimensions.height20),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    top: Dimensions.width5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                      bottom: Dimensions.height20
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20))),
                  child: Center(
                    child: AppColumn(text: model.name!)
                  ),
                ),
              ),
              expandedHeight: 300,
              pinned: true,
              backgroundColor: AppColors.mainColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                    AppConstants.BASE_URL + "/uploads/" + model.img!,
                    width: double.maxFinite,
                    fit: BoxFit.cover),
              ),
            ),

            SliverToBoxAdapter(
                child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height20),
              child: SmallText(
                  size: Dimensions.font16,
                  height: 1.8,
                  text: model.description!),
            ))
          ],
        );
      }),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) {
        CartItem model;
        switch (itemType) {
          case ItemType.popular: model = controller.popularProductList[index];
          case ItemType.recommended: model = controller.recommendedFood[index];
        }
        return Container(
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
                    GestureDetector(
                      onTap:() {
                        controller.setQuantity(false);
                        Get.find<RecommendedFoodController>().update();
                      },
                      child: Icon(Icons.remove, color: AppColors.signColor,),
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: controller.quantity.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                      onTap:() {
                        controller.setQuantity(true);
                        Get.find<RecommendedFoodController>().update();
                      },
                      child: Icon(Icons.add, color: AppColors.signColor,),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.height20, right: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    gradient: AppColors.gradient
                ),
                child:
                GestureDetector(
                    onTap: () {
                      CartQuantity status = controller.addItemToCart(model, index);
                      switch (status) {
                        case CartQuantity.success:break;
                      // Navigator.pop(context);
                      // _showSnackBar("Added to cart", controller.quantity.toString());
                        case CartQuantity.minCapacity:
                          _showSnackBar("Insufficient", "minimum quantity required is 1");
                        case CartQuantity.maxCapacity:
                          _showSnackBar("Cannot add anymore", "you have reached maximum capacity of 20");
                      }
                    },
                    child: BigText(text: "\$ ${model.price} | Add to cart", color: Colors.white,)
                ),
              )
            ],
          ),
        );
      })
    );
  }

  _showSnackBar(String title, String msg) {
    Get.snackbar(title, msg,
        backgroundColor: AppColors.mainColor,
        duration: const Duration(seconds: 1));
  }
}
