import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media/commons/http_authorization.dart';
import 'package:social_media/commons/utils/pretty_json.dart';
import 'package:social_media/logger.dart';

enum HttpRequestMethod { get, post, put, delete }

mixin HttpMixin {
  Dio? _dio;

  @mustCallSuper
  @protected
  void init() {
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onError: _onError,
    ));
    _dio = dio;
  }

  void _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (auth != null) {
      options.headers[HttpHeaders.authorizationHeader] = '$auth';
    }
    handler.next(options);
  }

  void _onError(DioError error, ErrorInterceptorHandler handler) async {
    RequestOptions requestOptions = error.requestOptions;
    Response? response = error.response;
    if (response != null) {
      logger.e(""
          "++++++++++++++++++++++++++++++++++++++++\n"
          "HttpStatusCode: ${response.statusCode}\n"
          "${response.data}\n"
          "++++++++++++++++++++++++++++++++++++++++");
      if (response.statusCode == 401) {
        await refreshToken();
        final opts =  Options(
            method: requestOptions.method, headers: requestOptions.headers);
        final cloneReq = await _dio!.request(
          requestOptions.path,
          options: opts,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
        );

        handler.resolve(cloneReq);
        return;
      }
    }
    logger.e(error);
    handler.reject(error);
  }

  @mustCallSuper
  Future<T> request<T>(
    String path,
    T Function(Map<String, dynamic>? map) decoder, {
    HttpRequestMethod method = HttpRequestMethod.get,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    ResponseType? responseType,
    bool includeCredential = true,
    int? timeout,
  }) async {
    final _client = _dio;
    if (_client == null) {
      throw Exception("Init Dio before call request");
    }

    String _method = method.name.toUpperCase();

    Map<String, String> _headers = headers ?? {};

    logger.d(""
        "++++++++++++++++++++++++++++++++++++++++\n"
        "$method: $serverUrl$path\n"
        "${data != null ? prettyJson(data) : ''}\n"
        "++++++++++++++++++++++++++++++++++++++++");

    RequestOptions _options = RequestOptions(
      baseUrl: serverUrl,
      path: path,
      method: _method,
      headers: _headers,
      data: data,
      queryParameters: queryParameters,
      responseType: responseType ?? ResponseType.json,
      receiveDataWhenStatusError: true,
      connectTimeout: timeout ?? 10 * 1000,
      receiveTimeout: timeout ?? 10 * 1000,
    );
    try {
      Response<Map<String, dynamic>> _response = await _client.fetch(_options);
      logger.d(""
          "++++++++++++++++++++++++++++++++++++++++\n"
          "${_response.data != null ? prettyJson(_response.data!) : ""}\n"
          "++++++++++++++++++++++++++++++++++++++++");

      return decoder(_response.data);
    } catch (e) {
      throw e;
    }
  }

  @protected
  Future<void> refreshToken();

  String get serverUrl;

  Authorization? get auth;
}
