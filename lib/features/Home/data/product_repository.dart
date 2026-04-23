import 'package:dio/dio.dart';
import 'package:my_app/core/database/isar_service.dart';
import 'package:my_app/core/database/sqflite_service.dart';
import 'package:my_app/features/Cart/models/cart_model.dart';
import 'package:my_app/features/Cart/models/purchased_product.dart';
import 'package:my_app/features/Home/data/models/categories.dart';
import 'package:my_app/features/Home/data/models/product_review.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/features/Home/data/product_api.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  final ProductApi api;
  final IsarService isarService = IsarService();
  final SqfliteService _dbHelper = SqfliteService();


  // Cache in-memory
  List<Products>? _cachedAllProducts;
  Map<String, List<Products>> _cachedByCategory = {};
  List<Categories>? _cachedCategories;
  List<Products>? _cachedBanners;

  ProductRepository(this.api);

  Future<List<Products>> getProducts() async {
    if (_cachedAllProducts != null) return _cachedAllProducts!;

    try {
      final response = await api.getProducts();
      final products = (response.data['products'] as List)
          .map((e) => Products.fromJson(e))
          .toList();

      _cachedAllProducts = products;
      return products;
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<List<Products>> getProductsByCategory(String category) async {
    if (_cachedByCategory.containsKey(category)) {
      return _cachedByCategory[category]!;
    }

    try {
      final response = await api.getProductsByCategory(category);
      final products = (response.data['products'] as List)
          .map((e) => Products.fromJson(e))
          .toList();

      _cachedByCategory[category] = products;
      return products;
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<List<Products>> getBanners() async {
    if (_cachedBanners != null) return _cachedBanners!;

    try {
      final response = await api.getBanners(); // limit=5
      final banners = (response.data['products'] as List)
          .map((e) => Products.fromJson(e))
          .toList();

      _cachedBanners = banners;
      return banners;
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<List<Categories>> getCategories() async {
    if (_cachedCategories != null) return _cachedCategories!;

    try {
      final response = await api.getCategories();
      final categories = (response.data as List)
          .map((e) => Categories.fromJson(e))
          .toList();

      _cachedCategories = categories;
      return categories;
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }
    Future<Products> getProductById(int id) async {
    try {
      final response = await api.getProductById(id);
      return Products.fromJson(response.data);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  void clearCache() {
    _cachedAllProducts = null;
    _cachedByCategory.clear();
    _cachedCategories = null;
    _cachedBanners = null;
  }

  // Review - insert
  Future<int> saveReview(ProductReview review) async {
    final db = await _dbHelper.database;
    return await db.insert(
      'reviews',
      review.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,  
    );
  }
  // Review - get by product
  Future<ProductReview?> getReviewByProduct(int productId) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'reviews',
      where: 'productId = ?',
      whereArgs: [productId],
    );
    if (maps.isNotEmpty) {
      return ProductReview.fromMap(maps.first);
    }
    return null;
  }
  // Save purchased products
  Future<void> savePurchasedProducts(List<CartItem> purchasedItems) async {
    final isar = isarService.db;
    final List<PurchasedProduct> purchasedProducts = purchasedItems.map((item) {
      return PurchasedProduct(productId: item.id.toString());
    }).toList();

    await isar.writeTxn(() async {
      await isar.purchasedProducts.putAll(purchasedProducts);
    });
  }

  String _mapError(DioException e) {
  if (e.type == DioExceptionType.connectionTimeout) {
    return "Timeout kết nối";
  }
  if (e.response?.statusCode == 404) {
    return "Không tìm thấy dữ liệu";
  }
  if(e.message=="Không có kết nối Internet!") {
    return "Không có kết nối Internet!";
  }
  return "Có lỗi xảy ra";
}
}

