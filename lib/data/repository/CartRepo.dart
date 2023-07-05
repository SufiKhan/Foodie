import 'dart:convert';
import "package:collection/collection.dart";

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workspace/Utils/AppConstants.dart';
import 'package:workspace/data/api/ApiClient.dart';

import '../../models/CartModel.dart';

class CartRepo extends GetxService {
  // final ApiClient apiClient;
  static const cartCacheKey = "cartList";
  static const cartHistoryCacheKey = "cartHistoryList";
  // CartRepo({required this.apiClient});
  final SharedPreferences preferences;
  CartRepo({required this.preferences});

  List<String> _cart = [];
  List<String> _cartHistory = [];

  void addToCartList(List<CartItem> items) {
    _cart=[];
    // remove all items and re-add all because same item with updated quantity might be coming and we dont want to duplicate
    for (var element in items) {
      _cart.add(jsonEncode(element));
    }
    preferences.setStringList(cartCacheKey, _cart);
  }

  List<CartItem> getCartList() {
    if (preferences.containsKey(cartCacheKey)) {
      _cart = preferences.getStringList(cartCacheKey)!;
    }
    List<CartModel> cartList = [];
    for (var element in _cart) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  void checkOut() {
    if (preferences.containsKey(cartHistoryCacheKey)) {
      _cartHistory = preferences.getStringList(cartHistoryCacheKey)!;
    }
    String time = DateTime.now().toString();
    for (var element in _cart) {
      CartModel model = CartModel.fromJson(jsonDecode(element));
      model.time = time;
      _cartHistory.add(jsonEncode(model));
    }
    preferences.setStringList(cartHistoryCacheKey, _cartHistory);
    preferences.remove(cartCacheKey);
  }

  Future <List<CartModel>> getCartHistoryList() async {
    if (preferences.containsKey(cartHistoryCacheKey)) {
      _cartHistory = preferences.getStringList(cartHistoryCacheKey)!;
    }
    List<CartModel> historyList = [];
    for (var element in _cartHistory) {
      historyList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return historyList.reversed.toList();
  }

}