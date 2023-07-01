import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/Utils/AppColors.dart';
import 'package:workspace/Utils/Dimensions.dart';
import 'package:workspace/Widgets/app_column.dart';
import 'package:workspace/Widgets/app_icon.dart';
import 'package:workspace/Widgets/big_text.dart';
import 'package:workspace/Widgets/expandable_text_widget.dart';
import 'package:workspace/controllers/CartController.dart';
import 'package:workspace/controllers/PopularProductController.dart';
import 'package:workspace/models/PopularProduct.dart';

import '../../Utils/AppConstants.dart';
import '../../helper/RouteHelper.dart';

class PopularFoodDetailPage extends StatelessWidget {
  final int index;
  const PopularFoodDetailPage({Key? key,
    required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PopularProductController controller = Get.find<PopularProductController>();
    ProductModel model = controller.popularProductList[index];
    controller.init(Get.find<CartController>(), model.id!);
    return Scaffold(
      body: GetBuilder<PopularProductController>(builder: (controller) {
        ProductModel model = controller.popularProductList[index];
        return Stack(
          children: [
            //background image
            Positioned(
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.popularFoodImageSize,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              AppConstants.BASE_URL+"/uploads/"+model.img!
                          )
                      )
                  ),
                )),
            //top bar buttons
            Positioned(
                top: Dimensions.height45,
                left: Dimensions.height20,
                right: Dimensions.height20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap:() {
                          Get.back();
                        },
                        child: AppIcon(icon: Icons.arrow_back_ios)
                    ),
                    controller.getTotalItem(model.id!) > 0?
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Badge(
                          largeSize: 20,
                          backgroundColor: AppColors.mainColor,
                          label:BigText(text: controller.cartItems.toString(),
                            size: 16,
                            color: Colors.white,),
                          child: const Card(
                              child: Padding (
                                padding:EdgeInsets.all(10),
                                child: Icon(Icons.shopping_cart_outlined),
                              )
                          )
                      )
                    ) : AppIcon(icon: Icons.shopping_cart_outlined),
                  ],
                )
            ),
            // food detail and stats
            Positioned(
                child: Container(
                    margin: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: Dimensions.popularFoodImageSize - 20),
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height20
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppColumn(text: model.name!,),
                        SizedBox(height: Dimensions.height20,),
                        BigText(text: "Introduce"),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ExpandableTextWidget(text: model.description!),
                          ),
                        )
                      ],
                    )

                )
            )
          ],
        );
      }),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) {
        ProductModel model = controller.popularProductList[index];
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
                      },
                      child: Icon(Icons.remove, color: AppColors.signColor,),
                    ),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: controller.quantity.toString()),
                    SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                      onTap:() {
                        controller.setQuantity(true);
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
      }),
    );
  }

  _showSnackBar(String title, String msg) {
    Get.snackbar(title,msg,
        backgroundColor: AppColors.mainColor,
        duration: const Duration(seconds: 1)
    );
  }
}
