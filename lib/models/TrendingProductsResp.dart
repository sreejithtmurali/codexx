import 'dart:convert';

TrendingProductsResp trendingProductsRespFromJson(String str) => TrendingProductsResp.fromJson(json.decode(str));

String trendingProductsRespToJson(TrendingProductsResp data) => json.encode(data.toJson());

class TrendingProductsResp {
  TrendingProductsResp({
    this.success,
    this.data,
  });

  TrendingProductsResp.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.items,
    this.pagination,
  });

  Data.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(ProductItem.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }

  List<ProductItem>? items;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }
}

class ProductItem {
  ProductItem({
    this.offerId,
    this.storeId,
    this.id,
    this.type,
    this.name,
    this.imageUrl,
    this.variant,
    this.inStock,
    this.pricing,
    this.offer,
    this.storeName,
    this.distanceKm,
    this.isFavorited,
    this.cartQuantity,
  });

  ProductItem.fromJson(dynamic json) {
    offerId = json['offerId'];
    storeId = json['storeId'];
    id = json['id'];
    type = json['type'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    variant = json['variant'];
    inStock = json['inStock'];
    pricing = json['pricing'] != null ? Pricing.fromJson(json['pricing']) : null;
    offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
    storeName = json['storeName'];
    distanceKm = json['distanceKm'];
    isFavorited = json['isFavorited'];
    cartQuantity = json['cartQuantity'];
  }

  String? offerId;
  String? storeId;
  String? id;
  String? type;
  String? name;
  String? imageUrl;
  dynamic variant;
  bool? inStock;
  Pricing? pricing;
  Offer? offer;
  String? storeName;
  dynamic distanceKm;
  bool? isFavorited;
  int? cartQuantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offerId'] = offerId;
    map['storeId'] = storeId;
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['imageUrl'] = imageUrl;
    map['variant'] = variant;
    map['inStock'] = inStock;
    if (pricing != null) {
      map['pricing'] = pricing?.toJson();
    }
    if (offer != null) {
      map['offer'] = offer?.toJson();
    }
    map['storeName'] = storeName;
    map['distanceKm'] = distanceKm;
    map['isFavorited'] = isFavorited;
    map['cartQuantity'] = cartQuantity;
    return map;
  }
}

class Pricing {
  Pricing({
    this.mrp,
    this.price,
    this.discountPercent,
    this.savings,
  });

  Pricing.fromJson(dynamic json) {
    mrp = json['mrp'] != null ? double.tryParse(json['mrp'].toString()) : 0.0;
    price = json['price'] != null ? double.tryParse(json['price'].toString()) : 0.0;
    discountPercent = json['discountPercent'];
    savings = json['savings'] != null ? double.tryParse(json['savings'].toString()) : 0.0;
  }

  double? mrp;
  double? price;
  int? discountPercent;
  double? savings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mrp'] = mrp;
    map['price'] = price;
    map['discountPercent'] = discountPercent;
    map['savings'] = savings;
    return map;
  }
}

class Offer {
  Offer({
    this.id,
    this.label,
  });

  Offer.fromJson(dynamic json) {
    id = json['id'];
    label = json['label'];
  }

  String? id;
  String? label;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['label'] = label;
    return map;
  }
}

class Pagination {
  Pagination({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  Pagination.fromJson(dynamic json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }

  int? page;
  int? limit;
  int? total;
  int? totalPages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['limit'] = limit;
    map['total'] = total;
    map['totalPages'] = totalPages;
    return map;
  }
}
