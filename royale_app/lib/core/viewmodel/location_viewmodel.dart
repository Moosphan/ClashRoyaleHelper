// Copyright 2020 Moosphon. All rights reserved.

import 'package:royale_app/core/model/game_locations_model.dart';
import 'package:royale_app/core/service/royale_repository.dart';
import 'package:royale_app/core/util/log_utils.dart';
import 'package:royale_app/core/viewmodel/base_vm.dart';
import 'package:royale_app/core/viewmodel/state.dart';

/// ViewModel to get and handle data of world game locations.
class LocationViewModel extends BaseViewModel {

  List<Location> _locationList;

  List<Location> get locationList => _locationList;

  // 获取世界地区列表
  Future<GameLocations> getLocations() async {
    applyState(ViewState.LOADING);
    try {
      GameLocations result = await RoyaleRepository.getAvailableLocations();
      Logger.e('获取游戏所有分布地区的结果：${result.toJson()}');
      if (result != null && result.items.length > 0) {
        applyState(ViewState.IDLE);
        refreshLocations(result.items);
      } else {
        applyState(ViewState.EMPTY);
      }
      return result;
    } catch (e, s) {
      applyState(ViewState.ERROR);
      handleError(e, s);
      return null;
    }
  }

  refreshLocations(list) {
    _locationList = list;
    notifyListeners();
  }
}