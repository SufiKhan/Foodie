import 'package:get/get.dart';
import 'package:workspace/models/Recommended.dart';
import '../data/repository/RecommendedFoodRepo.dart';
import '../models/CartModel.dart';
import 'CartController.dart';

class RecommendedFoodController extends GetxController {
  final RecommendedFoodRepo recommendedFoodRepo;

  RecommendedFoodController({required this.recommendedFoodRepo});
  List<dynamic> _recommendedFoodList = [];
  List<dynamic> get recommendedFood => _recommendedFoodList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _cartItems = 0;
  int get cartItems => _cartItems;
  late CartController _cartController;
  bool _canAddToCart = false;

  init(CartController cartController, int id) {
    _cartController = cartController;
    _quantity = getTotalItem(id);
    _cartItems=getTotalItem(id);
  }
  Future<void> getRecommendedFoodList() async {
    Response res = await recommendedFoodRepo.getRecommendedFoodList();
    if (res.statusCode == 200) {
      _recommendedFoodList = [];
      _recommendedFoodList.addAll(Recommended.fromJson(res.body).recommendedFoodList);
      _isLoaded = true;
      update();
    } else {
      // _isLoaded = true;
      print(res.statusCode);
    }
  }

  void setQuantity(bool isAdd) {
    if (isAdd) {
      _quantity = checkQuantity(_quantity+1);
    } else {
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }

  checkQuantity(int qty) {
    if (qty<=0) {
      _canAddToCart = false;
      return 0;
    } else if (qty>20) {
      _canAddToCart = false;
      return 20;
    } else {
      _canAddToCart = true;
      return qty;
    }
  }

  CartQuantity addItemToCart(CartItem item, int index) {
    if (_canAddToCart) {
      if (_cartController.getTotalItems(item.id!) + _quantity > 20 ) {
        return CartQuantity.maxCapacity;
      }
      _cartController.updateCart(item, _quantity, index);
      _canAddToCart = false;
      _cartItems = _quantity;
      update();
      return CartQuantity.success;
    }
    return CartQuantity.minCapacity;
  }

  getTotalItem(int id) {
    return _cartController.getTotalItems(id);
  }
}