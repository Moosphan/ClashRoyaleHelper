// Copyright 2020 Moosphon. All rights reserved.

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:royale_app/core/model/base/error_response.dart';
import 'package:royale_app/core/net/exceptions.dart';
import 'package:royale_app/core/resource/constants.dart';
import 'api.dart';
final TimeoryHttp http = TimeoryHttp();

_decodeJson(String response) {
  return jsonDecode(response);
}

parseJson(String json) {
  return compute(_decodeJson, json);
}

class TimeoryHttp extends DioForNative {
  TimeoryHttp() {
    /// initializations
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    initialize();
  }

  void initialize() {
    options.baseUrl = RoyaleApi.PROXY_BASE_URL;
    interceptors.add(HeaderInterceptor());
  }
}

class HeaderInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    options.connectTimeout = 1000 * 30;
    options.receiveTimeout = 1000 * 30;
    //options.headers['authorization'] = 'Bearer ${Constants.AUTH_KEY}';
    /// Use this new key to avoid official ip limit.
    options.headers['authorization'] = 'Bearer ${Constants.PROXY_KEY}';
    debugPrint('<***Royale-api***> url--> ${options.baseUrl}${options.path} -->' +
        'params--> ${options.queryParameters}' + 'data--> ${options.data}' + 'header--> ${options.headers}');
    return options;
  }

  @override
  Future onResponse(Response response) {
    debugPrint('''
      <-----↓↓↓↓↓↓↓↓↓↓-----Royale response-----↓↓↓↓↓↓↓↓↓↓----->
        ${response.statusCode} -- ${response.data}
      <-----↑↑↑↑↑↑↑↑↑↑---------- end -----------↑↑↑↑↑↑↑↑↑↑----->
    ''');
    if (response.statusCode != ApiReturnCode.SUCCESS) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(response.data);
      throw RoyaleApiRequestFailedException.fromResponseData(response.statusCode, errorResponse);
    } else {
      return http.resolve(response.data);
    }
  }

  @override
  Future onError(DioError err) {
    // API服务器请求问题
    if (err.response.statusCode != ApiReturnCode.SUCCESS) {
      ErrorResponse errorResponse = ErrorResponse.fromJson(err.response.data);
      throw RoyaleApiRequestFailedException.fromResponseData(err.response.statusCode, errorResponse);
    }
    return super.onError(err);
  }
}