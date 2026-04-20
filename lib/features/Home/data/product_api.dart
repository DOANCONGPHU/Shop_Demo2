import 'package:dio/dio.dart';

class ProductApi {
  final Dio dio;

  ProductApi(this.dio);

  Future<Response> getProducts() async {
    try {
      return await dio.get('/products');
    } on DioException {
      rethrow;
    }
  }

  Future<Response> getProductById(int id) async {
    try {
      return await dio.get('/products/$id');
    } on DioException {
      rethrow;
    }
  }
  
  Future<Response> getBanners() async {
    try {
      return await dio.get('/products?limit=5');
    } on DioException {
      rethrow;
    }
  }
  
  Future<Response> getCategories() async {
    try {
      return await dio.get('/products/categories');
    } on DioException {
      rethrow;
    }
  }
  
  Future<Response> getProductsByCategory(String category) async {
    try {
      return await dio.get('/products/category/$category');
    } on DioException {
      rethrow;
    }
  }
  
}
