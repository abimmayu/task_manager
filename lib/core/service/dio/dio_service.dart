import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final Dio _dio = Dio(BaseOptions(
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 10),
));

Future<Response> postIt(
  String url, {
  Map<String, dynamic>? body,
  Map<String, dynamic>? headers,
}) async {
  Logger().i("URL: $url");
  Logger().i(body);

  final response = await _dio.post(
    url,
    data: body,
    options: Options(
      validateStatus: (status) => status! < 500,
      headers: headers,
    ),
  );
  Logger().d("Response data: ${response.data}");
  return response;
}
