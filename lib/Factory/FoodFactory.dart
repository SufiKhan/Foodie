import 'package:get/get.dart';
import 'package:workspace/controllers/PopularProductController.dart';
import 'package:workspace/controllers/RecommendedFoodController.dart';
import 'package:workspace/data/repository/RecommendedFoodRepo.dart';
import '../data/repository/PopularProductRepo.dart';

abstract class FoodFactory {
  PopularProductController getPopularFoodController();
  RecommendedFoodController getRecommendedFoodController();
}

final class FoodFactoryImpl implements FoodFactory {
  @override
  PopularProductController getPopularFoodController() {
    PopularProductRepo repo = PopularProductRepo(apiClient: Get.find());
    return PopularProductController(popularProductRepo: repo);
  }

  @override
  RecommendedFoodController getRecommendedFoodController() {
    RecommendedFoodRepo repo = RecommendedFoodRepo(apiClient: Get.find());
    return RecommendedFoodController(recommendedFoodRepo: repo);
  }
}
