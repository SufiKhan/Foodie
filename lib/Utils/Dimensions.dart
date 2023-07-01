import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  static double pageViewContainers = screenHeight/3.84;
  static double pageViewTextContainers = screenHeight/7.03;
  static double pageView = screenHeight/2.64;
// dynamic padding and margin
  static double height5 = screenHeight/168.8;
  static double height10 = screenHeight/84.4;
  static double height15 = screenHeight/56.27;
  static double height20 = screenHeight/42.2;
  static double height30 = screenHeight/28.13;
  static double height45 = screenHeight/18.76;

// dynamic padding and margin
  static double width5 = screenWidth/168.8;
  static double width10 = screenWidth/84.4;
  static double width15 = screenWidth/56.27;
  static double width20 = screenWidth/42.2;
  static double width30 = screenWidth/28.13;
  static double width45 = screenWidth/18.76;

  // dynamic font
  static double font16 = screenHeight/52.75;
  static double font20 = screenHeight/42.2;
  static double font26 = screenHeight/32.46;

  // radius
  static double radius20 = screenHeight/42.2;
  static double radius15 = screenHeight/56.27;

  // icon size
  static double iconSize24 = screenHeight/35.17;
  static double iconSize16 = screenHeight/52.75;

  //food page: list view size
static double popularListViewImgSize = screenWidth/3.25;
static double popularListViewTxtContSize = screenWidth/3.9;

// Restaurants detail page
static double popularFoodImageSize = screenHeight/2.41;
static double bottomNavigationBarHeight = pageViewTextContainers;

static double splashImageHeight = screenHeight/3.37;
static double detailPageSliverBarHeight = screenHeight/6.83;
}