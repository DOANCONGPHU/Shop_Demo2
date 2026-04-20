import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://dummyjson.com',
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 30),
            contentType: 'application/json',
          ),
        ) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }
}