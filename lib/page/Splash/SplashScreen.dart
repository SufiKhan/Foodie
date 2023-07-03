import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workspace/Utils/AppColors.dart';
import 'package:workspace/Utils/Dimensions.dart';
import 'package:workspace/Widgets/big_text.dart';
import 'package:workspace/controllers/PopularProductController.dart';
import 'package:workspace/controllers/RecommendedFoodController.dart';
import 'package:workspace/helper/RouteHelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    ProductController controller = Get.find<ProductController>();
    await controller.getPopularProductList();
    await controller.getRecommendedFoodList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linearToEaseOut);
    Timer(
      const Duration(seconds: 3),
        ()=> Get.offNamed(RouteHelper.getInitial(0))
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation,
            child: Column(
              children: [
                Center(
                    child: Image.asset("assets/image/foodie.png",
                      width: Dimensions.splashImageHeight,
                    )
                ),Center(
                    child: BigText(text: "Only stop for best foods", color: AppColors.yellowColor, size: Dimensions.font26,)
                )
              ],
            )),
        ],
      ),
    );
  }
}
