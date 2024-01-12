import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:moviedb_demo/core/constants/app_constants.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log("Request[${options.method}] => PATH: ${options.path}");
    options.headers['Authorization'] = 'Bearer ${AppConstants.kAPIKey}';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("Response Status Code: [$response]");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log("Error[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");

    super.onError(err, handler);
  }
}
