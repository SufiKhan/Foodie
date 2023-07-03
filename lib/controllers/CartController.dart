import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/repository/CartRepo.dart';
import '../models/CartModel.dart';

enum CartQuantity {
  success,
  minCapacity,
  maxCapacity
}

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartItem> _items = {};
  Map<int, CartItem> get items => _items;
  List<CartItem> _orderHistory = [];
  List<CartItem> get historyList => _orderHistory;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    setAllCartItems = cartRepo.getCartList();
    setOrderHistory = await cartRepo.getCartHistoryList();
    super.onInit();
  }
  void updateCart(CartItem it, int quantity, int index) {
    if (it.id != null) {
      if (_items.containsKey(it.id!)) {
        _updateCartItemQuantity(it, quantity);
      } else {
        _addNewItem(it, quantity, index);
      }
      // CartItem? item = _items[it.id!];
      cartRepo.addToCartList(getItems());
    }
  }

  _addNewItem(CartItem item, int quantity, int index) {
    _items.putIfAbsent(item.id!, ()  {
      return CartModel(
          id: item.id,
          name: item.name,
          price: item.price,
          img: item.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          itemIndexInList: index,
          itemType: item.itemType,
          description: item.description
      );
    });
  }

  _updateCartItemQuantity(CartItem item, int quantity) {
    _items.update(item.id!, (value) {
      return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          itemIndexInList: value.itemIndexInList,
          description: item.description,
          itemType: item.itemType);
    });
    update();
  }

  int getTotalItems(int id) {
    if (_items.containsKey(id!)) {
      return _items[id!]!.quantity!;
    }
    return 0;
  }

  List<CartItem> getItems() {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  void updateCartPageList(CartItem item, int quantity) {
    if (quantity == 0) {
      _items.remove(item.id!);
      update();
      return;
    } else if (quantity > 20) {
      return;
    } else {
      updateCart(item, quantity, item.itemIndexInList!);
    }
  }

  int get totalAmount {
    int total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  set setAllCartItems(List<CartItem> items) {
      for (int i=0; i<items.length;i++) {
        _items.putIfAbsent(items[i].id!, () => items[i]);
      }
  }

  Future<void> checkOut() async {
    cartRepo.checkOut();
    _items ={};
    setOrderHistory = await cartRepo.getCartHistoryList();
    update();
  }

  // Future<List<CartModel>> getHistory() async {
  //   List<CartModel> hist = await cartRepo.getCartHistoryList();
  //   return hist;
  // }

  set setOrderHistory(List<CartModel> items) {
    _orderHistory = [];
    _orderHistory = items;
  }
}