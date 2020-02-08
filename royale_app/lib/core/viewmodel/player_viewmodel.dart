// Copyright 2020 Moosphon. All rights reserved.

import 'package:royale_app/core/model/chest_model.dart';
import 'package:royale_app/core/model/player_battle_log_model.dart';
import 'package:royale_app/core/model/player_model.dart';
import 'package:royale_app/core/service/royale_repository.dart';
import 'package:royale_app/core/util/log_utils.dart';
import 'package:royale_app/core/viewmodel/base_vm.dart';
import 'state.dart';

/// ViewModel to handle player data.
class PlayerViewModel extends BaseViewModel {

  // 玩家信息
  PlayerDetail _playerDetails;
  PlayerDetail get playerDetail => _playerDetails;

  // 玩家未来宝箱信息
  ChestList _chestList;
  ChestList get chestList => _chestList;

  // 玩家对战信息
  List<PlayerBattleLog> _battleList;
  List<PlayerBattleLog> get battleLog => _battleList;

  // 获取玩家信息
  Future<PlayerDetail> getPlayerDetail(String tag) async {
    applyState(ViewState.LOADING);
    try {
      PlayerDetail result = await RoyaleRepository.getPlayerInfo(tag);
      Logger.e('获取玩家信息的结果：${result.toJson()}');
      if (result != null) {
        applyState(ViewState.IDLE);
        refreshPlayerData(result);
        getUpcomingChests(tag);
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

  // 获取玩家未来宝箱数据
  Future<ChestList> getUpcomingChests(String tag) async {
    applyState(ViewState.LOADING);
    try {
      ChestList result = await RoyaleRepository.getPlayerUpcomingChests(tag);
      Logger.e('获取玩家未来奖励的结果：${result.toJson()}');
      if (result.items != null && result.items.length != 0) {
        applyState(ViewState.IDLE);
        refreshChestData(result);
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

  // 获取玩家对战信息
  Future<List<PlayerBattleLog>> getBattleLogs(String tag) async {
    applyState(ViewState.LOADING);
    try {
      var result = await RoyaleRepository.getPlayerBattleLog(tag);
      Logger.e('获取玩家对战记录的结果：${result.toString()}');
      if (result != null && result.length != 0) {
        applyState(ViewState.IDLE);
        refreshBattleInfo(result);
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

  void refreshPlayerData(PlayerDetail detail) {
    _playerDetails = detail;
    notifyListeners();
  }

  void refreshChestData(ChestList chests) {
    _chestList = chests;
    notifyListeners();
  }

  void refreshBattleInfo(List<PlayerBattleLog> battles) {
    _battleList = battles;
    notifyListeners();
  }
}