import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio _dio;

  DioClient({required String baseUrl, String? token})
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          headers: {
            'Accept': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      ) {
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: true,
      ),
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          // Forward standardized error message
          return handler.next(_mapError(e));
        },
      ),
    ]);
  }

  Dio get dio => _dio;

  DioException _mapError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return DioException(
        requestOptions: error.requestOptions,
        error: 'Waktu koneksi habis (Timeout)',
        type: error.type,
      );
    }

    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.unknown) {
      return DioException(
        requestOptions: error.requestOptions,
        error: 'Cek koneksi internet anda',
        type: error.type,
      );
    }

    if (error.type == DioExceptionType.badResponse) {
      final status = error.response?.statusCode;
      final message = error.response?.data is Map
          ? (error.response?.data['message'] ?? 'Terjadi kesalahan')
          : 'Terjadi kesalahan';
      return DioException(
        requestOptions: error.requestOptions,
        response: error.response,
        error: "[$status] $message",
        type: error.type,
      );
    }

    return error;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  void updateToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<List<int>> downloadImage(String imageUrl) async {
    const maxRetries = 5;
    const delaySeconds = 2;

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        if (attempt > 0) {
          await Future.delayed(Duration(seconds: delaySeconds * attempt));
          print('Image retry attempt ${attempt + 1}...');
        }

        final imageDio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 300),
            sendTimeout: const Duration(seconds: 30),
            headers: {
              'Accept': 'image/*,*/*',
              'User-Agent': 'Flutter App',
              'Connection': 'keep-alive',
            },
          ),
        );

        final response = await imageDio.get<List<int>>(
          imageUrl,
          options: Options(responseType: ResponseType.bytes),
        );

        if (response.statusCode == 200) {
          return response.data ?? [];
        } else {
          throw Exception("HTTP ${response.statusCode}");
        }
      } catch (e) {
        if (attempt == maxRetries - 1) {
          throw Exception('Gagal memuat gambar');
        }
      }
    }
    throw Exception('Gagal memuat gambar');
  }
}
