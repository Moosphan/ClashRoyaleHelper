// Copyright 2020 Moosphon. All rights reserved.


import 'package:royale_app/core/model/base/error_response.dart';
/// 请求异常处理
class RoyaleApiRequestFailedException implements Exception {
  String message;
  String reason;
  int errorCode;
  RoyaleApiRequestFailedException.fromResponseData(int code, ErrorResponse data) {
    message = data.message;
    reason = data.reason;
    errorCode = code;
  }

  @override
  String toString() {
    return 'RoyaleApiRequestFailedException{code: $errorCode, message: $message, reason: $reason}';
  }
}


