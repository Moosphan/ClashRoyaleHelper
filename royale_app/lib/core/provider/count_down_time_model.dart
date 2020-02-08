// Copyright 2019 Ucardstore LLC. All rights reserved.

import 'dart:async';

import 'package:flutter/material.dart';

/// 计时器 LiveData
/// @author Moosphon
class CountDownTimeModel extends ChangeNotifier {
  final int timeMax;
  final int interval;
  int _time;
  Timer _timer;

  int get currentTime => _time;

  bool get isFinish => _time == timeMax;

  CountDownTimeModel(this.timeMax, this.interval) {
    _time = timeMax;
  }

  void startCountDown() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    _timer = Timer.periodic(Duration(seconds: interval), (timer) {
      if (timer.tick == timeMax) {
        _time = timeMax;
        timer.cancel();
        timer = null;
      } else {
        _time--;
      }
      notifyListeners();
    });
  }

  void cancel() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer = null;
    super.dispose();
  }
}