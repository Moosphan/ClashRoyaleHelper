// Copyright 2020 Moosphon. All rights reserved.

import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as httpClient;
import 'package:royale_app/core/model/cards_available_model.dart';
import 'package:royale_app/core/model/chest_model.dart';
import 'package:royale_app/core/model/game_locations_model.dart';
import 'package:royale_app/core/model/player_battle_log_model.dart';
import 'package:royale_app/core/model/player_model.dart';
import 'package:royale_app/core/model/top_clans_model.dart';
import 'package:royale_app/core/model/top_players_model.dart';
import 'package:royale_app/core/net/api.dart';
import 'package:royale_app/core/net/http_client.dart';
import 'package:royale_app/core/util/log_utils.dart';

/// Remote data repository.
/// @author moosphon
class RoyaleRepository {

  // 获取排行榜顶级玩家数据
  /// [locationLimit] 作区域限制筛选
  static Future<PlayerRank> getTopRankPlayers({String locationLimit}) async {
   String url = RoyaleApi.LOCATION_DATA + '/' + locationLimit +  RoyaleApi.PLAYER_TOP;
    var response = await http.get(url, queryParameters: {
      'limit': 30
    });
    return PlayerRank.fromJson(response.data);
  }

  // 获取排行榜顶级部落数据
  /// [locationLimit] 作区域限制筛选
  static Future<ClansRank> getTopRankClans({String locationLimit}) async {
    String url = RoyaleApi.LOCATION_DATA + '/' + locationLimit +  RoyaleApi.CLAN_TOP;
    var response = await http.get(url, queryParameters: {
      'limit': 30
    });
    return ClansRank.fromJson(response.data);
  }


  // 根据玩家标签获取该玩家的详细信息
  /// [playerTag] 玩家的唯一标签
  static Future<PlayerDetail> getPlayerInfo(String playerTag) async {
    var response = await http.get(RoyaleApi.PLAYER_INFO + playerTag);
    return PlayerDetail.fromJson(response.data);
  }

  // 根据玩家标签获取该玩家的未来宝箱
  /// [playerTag] 玩家的唯一标签
  static Future<ChestList> getPlayerUpcomingChests(String playerTag) async {
    var response = await http.get(RoyaleApi.PLAYER_INFO + playerTag + RoyaleApi.CHESTS_INFO);
    return ChestList.fromJson(response.data);
  }

  // 获取游戏所有卡片数据 <目前数据细节尚不完善>
  static Future<AvailableCards> getAvailableCards() async {
    var response = await http.get(RoyaleApi.CARDS);
    return AvailableCards.fromJson(response.data);
  }

  // 获取游戏所有地区数据
  static Future<GameLocations> getAvailableLocations() async {
    var response = await http.get(RoyaleApi.LOCATION_DATA);
    return GameLocations.fromJson(response.data);
  }

  // 根据玩家标签获取该玩家的对战记录
  /// [playerTag] 玩家的唯一标签
  static Future<List<PlayerBattleLog>> getPlayerBattleLog(String playerTag) async {
    var response = await http.get(RoyaleApi.PLAYER_INFO + playerTag + RoyaleApi.BATTLE_INFO);
    List<PlayerBattleLog> battleList = (response.data as List).map((battle) => PlayerBattleLog.fromJson(battle)).toList();
    return battleList;
  }


  // 下载文件
  static Future downloadFile(String url, String savePath) async {
    var dio = Dio();
    dio.options.receiveTimeout = 30000;
    dio.options.connectTimeout = 30000;
    try {
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            //Logger.e('下载进度：${(received / total * 100).toStringAsFixed(0)}%');
          }
        }
      );
    } catch(e) {
      Logger.e('下载出异常了：$e');
    }

  }

  // 下载文件但不保存
  static Future<Uint8List> downloadWithoutSaving(String url) async {
    final response = await httpClient.get(url);
    if (response.statusCode == 200) {
      return ByteData.view(response.bodyBytes.buffer).buffer.asUint8List();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to download this picture: $url');
    }
  }

}