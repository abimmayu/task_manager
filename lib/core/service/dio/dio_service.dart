import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Future<Response> postIt(String url, {Map<String, dynamic>? headers}) async {
  Logger().i(url);
  final response = await Dio().post(
    url,
    options: Options(
      headers: headers,
      receiveTimeout: const Duration(milliseconds: 5000),
      sendTimeout: const Duration(milliseconds: 6000),
    ),
  );
  Logger().d(response.data);
  return response;
}
