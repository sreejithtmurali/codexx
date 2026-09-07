import 'dart:convert';

NearbyStoresResp nearbyStoresRespFromJson(String str) => NearbyStoresResp.fromJson(json.decode(str));

String nearbyStoresRespToJson(NearbyStoresResp data) => json.encode(data.toJson());

class NearbyStoresResp {
  NearbyStoresResp({
    this.success,
    this.data,
  });

  NearbyStoresResp.fromJson(dynamic json) {
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
        items?.add(StoreItem.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }

  List<StoreItem>? items;
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

class StoreItem {
  StoreItem({
    this.id,
    this.name,
    this.category,
    this.distanceKm,
    this.logoUrl,
    this.imageUrl,
    this.rating,
    this.ratingCount,
    this.isOpen,
    this.isFavorited,
  });

  StoreItem.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    distanceKm = json['distanceKm'] != null ? double.tryParse(json['distanceKm'].toString()) : 0.0;
    logoUrl = json['logoUrl'];
    imageUrl = json['imageUrl'];
    rating = json['rating'] != null ? double.tryParse(json['rating'].toString()) : 0.0;
    ratingCount = json['ratingCount'];
    isOpen = json['isOpen'];
    isFavorited = json['isFavorited'];
  }

  String? id;
  String? name;
  String? category;
  double? distanceKm;
  String? logoUrl;
  String? imageUrl;
  double? rating;
  int? ratingCount;
  bool? isOpen;
  bool? isFavorited;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category'] = category;
    map['distanceKm'] = distanceKm;
    map['logoUrl'] = logoUrl;
    map['imageUrl'] = imageUrl;
    map['rating'] = rating;
    map['ratingCount'] = ratingCount;
    map['isOpen'] = isOpen;
    map['isFavorited'] = isFavorited;
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
