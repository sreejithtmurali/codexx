import 'package:flutter/material.dart';
import '../models/NearbyStoresResp.dart';
import '../models/TrendingProductsResp.dart';
import '../models/store_models.dart';
import '../services/apiservice.dart';

class DashboardProvider extends ChangeNotifier {
  final Apiservice _apiService;

  bool _isLoadingStores = false;
  bool _isLoadingProducts = false;
  String? _error;

  List<Store> _nearbyStores = [];
  List<Product> _trendingProducts = [];

  DashboardProvider(this._apiService);

  bool get isLoadingStores => _isLoadingStores;
  bool get isLoadingProducts => _isLoadingProducts;
  String? get error => _error;
  List<Store> get nearbyStores => _nearbyStores;
  List<Product> get trendingProducts => _trendingProducts;

  Future<void> fetchNearbyStores() async {
    _isLoadingStores = true;
    _error = null;
    notifyListeners();

    try {
      // Using default lat/lng for now as location service is not implemented
      final response = await _apiService.nearbyStores(10.0, 76.0);
      if (response != null && response.success == true) {
        _nearbyStores = response.data?.items?.map((e) => Store(
          id: e.id ?? '',
          name: e.name ?? '',
          image: e.logoUrl ?? '',
          type: e.category ?? '',
          distance: '${e.distanceKm ?? '0'} km',
          rating: e.rating ?? 0.0,
          isOpen: e.isOpen ?? true,
        )).toList() ?? [];
      } else {
        _error = "Failed to load stores";
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingStores = false;
      notifyListeners();
    }
  }

  Future<void> fetchTrendingProducts() async {
    _isLoadingProducts = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.trendingProducts();
      if (response != null && response.success == true) {
        _trendingProducts = response.data?.items?.map((e) => Product(
          id: e.id ?? '',
          title: e.name ?? '',
          store: e.storeName ?? '',
          image: e.imageUrl ?? '',
          price: e.pricing?.price ?? 0.0,
          oldPrice: e.pricing?.mrp ?? 0.0,
          unit: e.offer?.label ?? '',
          rating: 0.0, // Rating not in trending product item response provided
        )).toList() ?? [];
      } else {
        _error = "Failed to load products";
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoadingProducts = false;
      notifyListeners();
    }
  }

  Future<void> init() async {
    await Future.wait([
      fetchNearbyStores(),
      fetchTrendingProducts(),
    ]);
  }
}
