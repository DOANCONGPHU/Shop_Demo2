import 'package:dio/dio.dart';
import 'package:my_app/features/Home/data/models/categories.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/features/Home/data/product_api.dart';

class ProductRepository {
  final ProductApi api;

  ProductRepository(this.api);

  Future<List<Products>> getProducts() async {
    try {
      final response = await api.getProducts();

      return (response.data['products'] as List)
          .map((e) => Products.fromJson(e))
          .toList();
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

  Future<List<Products>> getBanners() async {
    try {
      final response = await api.getBanners();
      return (response.data['products'] as List)
          .map((e) => Products.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<List<Categories>> getCategories() async {
    try {
      final response = await api.getCategories();
      return (response.data as List)
          .map((e) => Categories.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<List<Products>> getProductsByCategory(String category) async {
    try {
      final response = await api.getProductsByCategory(category);
      return (response.data['products'] as List)
          .map((e) => Products.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  String _mapError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return "Timeout kết nối";
    }
    if (e.response?.statusCode == 404) {
      return "Không tìm thấy dữ liệu";
    }
    return "Có lỗi xảy ra";
  }
}
