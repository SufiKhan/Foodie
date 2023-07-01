import 'package:get/get.dart';
import 'package:workspace/Utils/AppConstants.dart';
import 'package:workspace/data/api/ApiClient.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.PRODUCTS_POPULAR_API);
  }

  Future<Response> getRecommendedFoodList() async {
    return await apiClient.getData(AppConstants.RECOMMEDED_PRODUCTS_API);
  }
}