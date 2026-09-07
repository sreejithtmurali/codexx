import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class Apiservice {
  late Dio _dio;
  final logger = Logger();

  // Set after Verify OTP, used by all authenticated calls.
  String? customerToken;
  String? customerRefreshToken;

  Apiservice() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://outmesmart.codeedextechnologies.com",
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (customerToken != null) {
          options.headers["Authorization"] = "Bearer $customerToken";
        }
        logger.i("url:${options.path}");
        logger.i("method:${options.method}");
        logger.i("baseurl:${options.baseUrl}");
        logger.i("headers:${options.headers}");
        logger.i("data:${options.data}");
        handler.next(options);
      },
      onResponse: (response, handler) {
        logger.i("statusCode:${response.statusCode}");
        logger.i("resp:${response.data}");
        handler.next(response);
      },
      onError: (error, handler) {
        logger.e("err:${error.message}");
        logger.e("stack trace:${error.stackTrace}");
        handler.next(error);
      },
    ));
  }

  // ================= AUTH =================

  Future<Response?> requestOtp(String phone) async {
    var data = {"phone": phone};
    final response =
    await _dio.post("/api/v1/customer/auth/otp/request", data: data);
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }

  // POST /api/v1/customer/auth/otp/verify
  Future<Response?> verifyOtp(
      String phone, String code, String name, String email) async {
    var data = {
      "phone": phone,
      "code": code,
      "name": name,
      "email": email,
    };
    final response =
    await _dio.post("/api/v1/customer/auth/otp/verify", data: data);
    if (response.statusCode == 200) {
      customerToken = response.data["data"]["accessToken"];
      customerRefreshToken = response.data["data"]["refreshToken"];
      return response;
    }
    return null;
  }

  // POST /api/v1/customer/auth/refresh
  Future<Response?> refresh() async {
    var data = {"refreshToken": customerRefreshToken};
    final response =
    await _dio.post("/api/v1/customer/auth/refresh", data: data);
    if (response.statusCode == 200) {
      customerToken = response.data["data"]["accessToken"];
      customerRefreshToken = response.data["data"]["refreshToken"];
      return response;
    }
    return null;
  }

  // POST /api/v1/customer/auth/logout
  Future<Response?> logout() async {
    var data = {"refreshToken": customerRefreshToken};
    final response =
    await _dio.post("/api/v1/customer/auth/logout", data: data);
    if (response.statusCode == 200) {
      customerToken = null;
      customerRefreshToken = null;
      return response;
    }
    return null;
  }

  // ================= CART =================

  // GET /api/v1/customer/cart
  Future<Response?> listMyCarts() async {
    final response = await _dio.get("/api/v1/customer/cart");
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }

  // GET /api/v1/customer/cart/{storeId}
  Future<Response?> getStoreCart(String storeId) async {
    final response = await _dio.get("/api/v1/customer/cart/$storeId");
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }

  // POST /api/v1/customer/cart/items
  Future<Response?> addCartItem(
      String storeId, String productId, String productType, int qty) async {
    var data = {
      "storeId": storeId,
      "productId": productId,
      "productType": productType,
      "qty": qty,
    };
    final response = await _dio.post("/api/v1/customer/cart/items", data: data);
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }

  // GET /api/v1/customer/cart/{storeId}/summary
  Future<Response?> getOrderSummary(String storeId) async {
    final response = await _dio.get("/api/v1/customer/cart/$storeId/summary");
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }

  // PATCH /api/v1/customer/cart/items/{id}
  Future<Response?> updateCartItemQty(String itemId, int qty) async {
    var data = {"qty": qty};
    final response =
    await _dio.patch("/api/v1/customer/cart/items/$itemId", data: data);
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }

  // DELETE /api/v1/customer/cart/items/{id}
  Future<Response?> removeCartItem(String itemId) async {
    final response = await _dio.delete("/api/v1/customer/cart/items/$itemId");
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }

  // ================= HOMEPAGE =================

  // GET /api/v1/customer/store-categories
  Future<Response?> listStoreCategories(
      {int page = 1, int limit = 20, String search = ""}) async {
    final response = await _dio.get(
      "/api/v1/customer/store-categories",
      queryParameters: {"page": page, "limit": limit, "search": search},
    );
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }

  // GET /api/v1/customer/stores/nearby
  Future<Response?> nearbyStores(
      double lat,
      double lng, {
        int page = 1,
        int limit = 20,
        String? categoryId,
        String sortBy = "distance",
        String sortOrder = "asc",
      }) async {
    final response = await _dio.get(
      "/api/v1/customer/stores/nearby",
      queryParameters: {
        "lat": lat,
        "lng": lng,
        "page": page,
        "limit": limit,
        if (categoryId != null) "categoryId": categoryId,
        "sortBy": sortBy,
        "sortOrder": sortOrder,
      },
    );
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }

  // GET /api/v1/customer/offers/trending
  Future<Response?> trendingProducts(
      {int page = 1, int limit = 20, String? storeId}) async {
    final response = await _dio.get(
      "/api/v1/customer/offers/trending",
      queryParameters: {
        "page": page,
        "limit": limit,
        if (storeId != null) "storeId": storeId,
      },
    );
    if (response.statusCode == 200) {
      return response;
    }
    return null;
  }
}