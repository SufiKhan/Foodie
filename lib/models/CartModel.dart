
import 'package:get/get.dart';

enum ItemType  {
  popular,
  recommended
}
abstract class CartItem {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  int? itemIndexInList;
  late ItemType itemType;
  String? description;
}
class CartModel implements CartItem {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  int? itemIndexInList;
  late ItemType itemType;
  String? description;

  CartModel({this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,
    required this.itemIndexInList,
    required this.itemType,
    this.description
  });


  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    itemIndexInList = json['itemIndexInList'];
    itemType = ItemType.values.firstWhereOrNull((e) => "ItemType.${e.name}" == json['itemType'])!;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['img'] = this.img;
    data['quantity'] = this.quantity;
    data['isExist'] = this.isExist;
    data['time'] = this.time;
    data['itemIndexInList'] = this.itemIndexInList;
    data['itemType'] = this.itemType.toString();
    data['description'] = this.description;
    return data;
  }
}