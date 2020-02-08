// Copyright 2020 Moosphon. All rights reserved.

import 'package:royale_app/core/model/top_clans_model.dart';
import 'package:royale_app/core/model/top_players_model.dart';
import 'package:royale_app/core/service/royale_repository.dart';
import 'package:royale_app/core/util/log_utils.dart';
import 'package:royale_app/core/viewmodel/state.dart';
import 'base_vm.dart';

/// ViewModel to handle player and clan ranks data and logic.
class RankViewModel extends BaseViewModel {

  // 获取玩家排行榜
  Future<PlayerRank> getPlayerRank({String country}) async {
    applyState(ViewState.LOADING);
    try {
      PlayerRank result = await RoyaleRepository.getTopRankPlayers(locationLimit: country);
      Logger.e('获取玩家排行榜的结果：${result.toJson()}');
      if (result != null && result.items.length > 0) {
        applyState(ViewState.IDLE);
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

  // 获取部落排行榜
  Future<ClansRank> getClanRank({String country}) async {
    applyState(ViewState.LOADING);
    try {
      ClansRank result = await RoyaleRepository.getTopRankClans(locationLimit: country);
      Logger.e('获取部落排行榜的结果：${result.toJson()}');
      if (result != null && result.items.length > 0) {
        applyState(ViewState.IDLE);
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

}