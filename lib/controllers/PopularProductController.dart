import 'package:get/get.dart';
import 'package:workspace/data/repository/PopularProductRepo.dart';

import '../models/CartModel.dart';
import '../models/PopularProduct.dart';
import '../models/Recommended.dart';
import 'CartController.dart';

class PopularProductController extends GetxController {
    final PopularProductRepo popularProductRepo;

    PopularProductController({required this.popularProductRepo });
    List<dynamic> _popularProductList = [];
    List<dynamic> get popularProductList => _popularProductList;
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
      Response res = await popularProductRepo.getRecommendedFoodList();
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

    Future<void> getPopularProductList() async {
      Response res = await popularProductRepo.getPopularProductList();
      if (res.statusCode == 200) {
        _popularProductList = [];
        _popularProductList.addAll(Product.fromJson(res.body).products);
        _isLoaded = true;
         update();
      } else {
          print(res.statusCode  );
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