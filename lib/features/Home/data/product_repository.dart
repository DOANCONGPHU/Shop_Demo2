import 'package:dio/dio.dart';
import 'package:my_app/features/Home/data/models/categories.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/features/Home/data/product_api.dart';

// class ProductRepository {
//   final ProductApi api;

//   ProductRepository(this.api);

//   Future<List<Products>> getProducts() async {
//     try {
//       final response = await api.getProducts();

//       return (response.data['products'] as List)
//           .map((e) => Products.fromJson(e))
//           .toList();
//     } on DioException catch (e) {
//       throw _mapError(e);
//     }
//   }

//   Future<Products> getProductById(int id) async {
//     try {
//       final response = await api.getProductById(id);
//       return Products.fromJson(response.data);
//     } on DioException catch (e) {
//       throw _mapError(e);
//     }
//   }

//   Future<List<Products>> getBanners() async {
//     try {
//       final response = await api.getBanners();
//       return (response.data['products'] as List)
//           .map((e) => Products.fromJson(e))
//           .toList();
//     } on DioException catch (e) {
//       throw _mapError(e);
//     }
//   }

//   Future<List<Categories>> getCategories() async {
//     try {
//       final response = await api.getCategories();
//       return (response.data as List)
//           .map((e) => Categories.fromJson(e))
//           .toList();
//     } on DioException catch (e) {
//       throw _mapError(e);
//     }
//   }

//   Future<List<Products>> getProductsByCategory(String category) async {
//     try {
//       final response = await api.getProductsByCategory(category);
//       return (response.data['products'] as List)
//           .map((e) => Products.fromJson(e))
//           .toList();
//     } on DioException catch (e) {
//       throw _mapError(e);
//     }
//   }


// }


class ProductRepository {
  final ProductApi api;

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
  // Clear cache khi cần (ví dụ pull-to-refresh)
  void clearCache() {
    _cachedAllProducts = null;
    _cachedByCategory.clear();
    _cachedCategories = null;
    _cachedBanners = null;
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