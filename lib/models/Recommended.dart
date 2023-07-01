import 'package:workspace/models/CartModel.dart';

class Recommended {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<RecommendedFoodModel> _recommendedFoodList;
  List<RecommendedFoodModel> get recommendedFoodList => _recommendedFoodList;

    Recommended({required totalSize, required typeId, required offset, required recommendedFoodList}) {
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _recommendedFoodList = recommendedFoodList;
  }

  Recommended.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _recommendedFoodList = <RecommendedFoodModel>[];
      json['products'].forEach((v) {
        _recommendedFoodList!.add(new RecommendedFoodModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = _totalSize;
    data['type_id'] = _typeId;
    data['offset'] = _offset;
    if (_recommendedFoodList != null) {
      data['products'] = _recommendedFoodList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecommendedFoodModel implements CartItem {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;
  @override
  ItemType itemType = ItemType.recommended;

  RecommendedFoodModel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.stars,
        this.img,
        this.location,
        this.createdAt,
        this.updatedAt,
        required this.itemType,
        this.typeId});

  RecommendedFoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
    itemType = ItemType.recommended;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['stars'] = this.stars;
    data['img'] = this.img;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type_id'] = this.typeId;
    data['itemType'] = this.itemType;
    return data;
  }

  @override
  bool? isExist;

  @override
  int? quantity;

  @override
  String? time;

  @override
  int? itemIndexInList;
}
