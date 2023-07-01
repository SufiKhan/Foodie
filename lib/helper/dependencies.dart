import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workspace/Utils/AppConstants.dart';
import 'package:workspace/controllers/CartController.dart';
import 'package:workspace/controllers/PopularProductController.dart';
import 'package:workspace/controllers/RecommendedFoodController.dart';
import 'package:workspace/controllers/TabbarController.dart';
import 'package:workspace/data/api/ApiClient.dart';
import 'package:workspace/data/repository/CartRepo.dart';
import 'package:workspace/data/repository/PopularProductRepo.dart';
import 'package:workspace/data/repository/RecommendedFoodRepo.dart';


Future<void> init() async {
  //api client
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl:AppConstants.BASE_URL));

  // Get.lazyPut(() => PopularProductController(popularProductRepo: PopularProductRepo(apiClient: Get.find())));
  Get.put(PopularProductController(popularProductRepo: PopularProductRepo(apiClient: Get.find())), permanent: true);
  Get.put(RecommendedFoodController(recommendedFoodRepo: RecommendedFoodRepo(apiClient: Get.find())), permanent: true);
  // Get.lazyPut(() => RecommendedFoodController(recommendedFoodRepo: RecommendedFoodRepo(apiClient: Get.find())));

  Get.put(CartController(cartRepo: CartRepo(preferences: sharedPreferences)), permanent: true);
  Get.put(TabbarController());
}