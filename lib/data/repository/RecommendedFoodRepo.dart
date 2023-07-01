import 'package:get/get.dart';
import 'package:workspace/Utils/AppConstants.dart';
import 'package:workspace/data/api/ApiClient.dart';


class RecommendedFoodRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedFoodRepo({required this.apiClient});

  Future<Response> getRecommendedFoodList() async {
    return await apiClient.getData(AppConstants.RECOMMEDED_PRODUCTS_API);
  }
}