import 'package:get/get.dart';
import 'package:workspace/page/Orders/OrderHistory.dart';
import 'package:workspace/page/Orders/TrackOrderPage.dart';
import 'package:workspace/page/Splash/SplashScreen.dart';
import 'package:workspace/page/Tabbar/TabbarPage.dart';
import 'package:workspace/page/cart/CartPage.dart';
import 'package:workspace/page/food/FoodDetailPage.dart';
import '../models/CartModel.dart';

class RouteHelper {
  static const String splashScreen="/";
  static const String initial="/initial";
  static const String foodDetail="/food-detail";
  static const String cartPage="/cart-page";
  static const String history="/history-page";
  static const String trackOrder="/trackOrder";

  static String getSplash()=>'$splashScreen';
  static String getInitial(int index)=>'$initial?index=$index';
  static String getFoodDetail(int index, ItemType type)=>'$foodDetail?index=$index&type=$type';
  static String getCartPage()=>'$cartPage';
  static String getHistoryPage()=>'$history';
  static String getTrackOrderPage()=>'$trackOrder';


  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: ()=> SplashScreen()),
    GetPage(name: initial, page: (){
      return TabbarPage(selectedTabIndex: int.parse(Get.parameters['index']!));
    }),
    GetPage(name: foodDetail, page: () {
      String str = Get.parameters['type']!;
      ItemType? itemType = ItemType.values.firstWhereOrNull((e) => "ItemType.${e.name}" == str);
      return FoodDetailPage(index: int.parse(Get.parameters['index']!), itemType: itemType!);
    }),
    GetPage(name: cartPage, page: (){
      return CartPage();
    }, transition: Transition.fadeIn),

    GetPage(name: history, page: (){
      return OrderHistory();
    }, transition: Transition.fadeIn),

    GetPage(name: trackOrder, page: () {
      print(Get.arguments);
      return const TrackOrderPage();
    }, transition: Transition.fadeIn),
  ];

  static presentDetailPage(int index, ItemType type) {
    Get.to(()=> FoodDetailPage(index: index, itemType: type), fullscreenDialog: true);
  }
}