// Copyright 2020 Moosphon. All rights reserved.
import 'package:royale_app/core/model/cards_available_model.dart';
import 'package:royale_app/core/model/common_model.dart';
import 'package:royale_app/core/service/royale_repository.dart';
import 'package:royale_app/core/util/log_utils.dart';
import 'package:royale_app/core/viewmodel/state.dart';
import 'base_vm.dart';

/// ViewModel to handle cards data and logic.
class CardViewModel extends BaseViewModel {

  List<RoleCard> _cardList;

  List<RoleCard> get cardList => _cardList;

  // 获取玩家排行榜
  Future<AvailableCards> getCards() async {
    applyState(ViewState.LOADING);
    try {
      AvailableCards result = await RoyaleRepository.getAvailableCards();
      Logger.e('获取游戏所有卡片的结果：${result.toJson()}');
      if (result != null && result.items.length > 0) {
        applyState(ViewState.IDLE);
        refreshCards(result.items);
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

  refreshCards(list) {
    _cardList = list;
    notifyListeners();
  }

}