// Copyright 2020 Moosphon. All rights reserved.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:royale_app/core/net/exceptions.dart';
import 'package:royale_app/core/viewmodel/state.dart';

/// Just like ViewModel in Android JetPack
/// Presenter handler between  view layer and data logic layer.
/// @author Moosphon
class BaseViewModel extends ChangeNotifier {

  // 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  ViewState _viewState;

  BaseViewModel({ViewState viewState})
      : _viewState = viewState ?? ViewState.IDLE;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  // do judgement whether is under loading state
  bool get isLoading => viewState == ViewState.LOADING;

  // do judgement whether is under overdue state
  bool get isOverdue => viewState == ViewState.OVERDUE;

  // do judgement whether is under empty state
  bool get isEmpty => viewState == ViewState.EMPTY;

  // change state of view
  void applyState(state) => viewState = state;

  // callback if under overdue
  void onOverdue() {
    Fluttertoast.showToast(msg: '用户信息过期请重新登录！');
  }

  // display error message
  void showError(code, message) {
    if (code == 10001) {
      message = '网络连接异常，请检查后重试';
    }
    Fluttertoast.showToast(msg: message ?? '未知错误');

  }

  // handle exceptions
  void handleError(e, s) {
    String message;
    int code;
    if (e is DioError) {
      e = e.error;
      if (e is RoyaleApiRequestFailedException) {
        // 服务器错误
        s = null;
        message = '${e.reason} | ${e.message}';
        code = e.errorCode;
      } else {
        // 网络异常
        message = e.toString();
        code = 10001;
      }
    } else {
      message = e.toString();
      code = -1;
    }

    viewState = ViewState.ERROR;
    showError(code, message);
    printError(e, s);
  }

  // print stack info
  printError(e, s) {
    debugPrint(
      '''
      <-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
      $e
      <-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑-----> 
      
      ''');
    if (s != null) debugPrint('''
      <-----↓↓↓↓↓↓↓↓↓↓-----stacktrace-----↓↓↓↓↓↓↓↓↓↓----->
      $s
      <-----↑↑↑↑↑↑↑↑↑↑-----stacktrace-----↑↑↑↑↑↑↑↑↑↑----->
    ''');
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }



}