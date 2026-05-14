import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
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
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          var connectivityResult = await Connectivity().checkConnectivity();
          if (connectivityResult.contains(ConnectivityResult.none)) {
            return handler.reject(
              DioException(
                requestOptions: options,
                message: "Không có kết nối Internet!",
              ),
            );
          }
          return handler.next(options);
        },
      ),
    );
  }
}

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(DioClient dioClient) => dioClient.dio;
}