import 'package:dio/dio.dart';
import 'package:github_search/feature/api.dart';

class DioManager {
  static Dio? _dio;

  static Dio get dio {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: Api.basePath,
      );

      _dio = Dio(options);

      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onResponse: (response, handler) {
            return handler.next(response);
          },
          onError: (DioException error, handler) {
            return handler.next(error);
          },
        ),
      );
    }
    return _dio!;
  }
}