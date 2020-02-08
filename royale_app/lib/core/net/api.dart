// Copyright 2020 Moosphon. All rights reserved.

import 'package:royale_app/core/resource/constants.dart';

/// API service from server.
class RoyaleApi {
  RoyaleApi._();

  static const BASE_URL = 'https://api.clashroyale.com/v1/';

  /// 玩家数据

  // 查看玩家详细信息 eg: < https://api.clashroyale.com/v1/players/%232RQGL00G8 >
  static const String PLAYER_INFO = "players/";

  // 查看玩家战斗记录 eg: < https://api.clashroyale.com/v1/players/%232RQGL00G8/battlelog >
  static const String BATTLE_INFO = "/battlelog";

  // 查看玩家未来宝箱 eg: < https://api.clashroyale.com/v1/players/%232RQGL00G8/upcomingchests >
  static const String CHESTS_INFO = "/upcomingchests";


  /// 部落数据
  // 查找符合条件部落 eg: < https://api.clashroyale.com/v1/clans?name=%E9%A3%8E%E9%9B%A8%E7%9A%84 >
  static const String SEARCH_CLAN = "clans";

  // 查看目标部落详情 eg: < https://api.clashroyale.com/v1/clans/TAG >
  static const String CLAN_DETAIL = "clans/";

  // 查看部落成员 eg: < https://api.clashroyale.com/v1/clans/TAG/members >
  static const String CLAN_MEMBERS = "/members";

  // 查看部落战斗记录 eg: < https://api.clashroyale.com/v1/clans/TAG/warlog >
  static const String CLAN_WAR_LOG = "/warlog";

  // 查看部落当前战争记录 eg: < https://api.clashroyale.com/v1/clans/TAG/currentwar >
  static const String CLAN_WAR_NOW = "/currentwar";

  /// 锦标赛数据

  // 搜索锦标赛(根据名字) eg: < https://api.clashroyale.com/v1/tournaments?name=<NAME> >
  static const String TOURNAMENT_SEARCH = "tournaments";

  // 查找锦标赛(根据TAG) eg: < https://api.clashroyale.com/v1/tournament/#20YU0VJ9 >
  static const String TOURNAMENT_INFO = "tournaments/";


  /// 地区数据

  // 查看某地区数据
  static const String LOCATION_DATA = 'locations';

  // 查看某地区排行榜顶级玩家 eg: < 中国地区: https://api.clashroyale.com/v1/locations/57000056/rankings/players >
  static const String PLAYER_TOP = "/rankings/players";

  // 查看某地区排行榜顶级部落 eg: < 中国地区: https://api.clashroyale.com/v1/locations/57000056/rankings/clans >
  static const String CLAN_TOP = "/rankings/clans";

  // 查看某地区部落战争排行榜 eg: < 中国地区: https://api.clashroyale.com/v1/locations/57000056/rankings/clanwars >
  static const String CLAN_WAR_TOP = "/rankings/clanwars";

  /// 卡组数据
  // 查看卡片信息 e.g: < https://api.clashroyale.com/v1/cards >
  static const String CARDS = 'cards';


}

class ApiReturnCode {
  // 请求成功
  static const SUCCESS = 200;
  // 参数错误
  static const INCORRECT_PARAMS = 400;
  // 非法授权
  static const ACCESS_DENIED = 403;
  // Not Found
  static const NOT_FOUND = 404;
  // 请求频繁
  static const REQUEST_TOO_MUCH = 429;
  // 未知错误
  static const UNKNOWN_ERROR = 500;
  // 服务器异常
  static const SERVER_ERROR = 503;
}