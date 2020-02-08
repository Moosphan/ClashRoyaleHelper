// Copyright 2020 Moosphon. All rights reserved.
/// 常量配置
class Constants {

  // 本地数据缓存文件名
  static const LOCAL_STORAGE_FILE = 'tiemory_storage';

  // 正则验证
  static const REGEX_MOBILE_EXACT = '^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[6])|(17[0,1,3,5-8])|(18[0-9])|(19[1,8,9]))\\d{8}\$';
  static const REGEX_EMAIL_EXACT = '^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$';
  static const REGEX_USERNAME = r'^[\\w\\u4e00-\\u9fa5]{6,20}(?<!_)$';
  static const REGEX_PASSWORD = r'^[a-zA-Z]\w{5,15}$';
  static const REGEX_SECURITY_CODE = r'^\d{6}$';

  static const String AUTH_KEY = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImM1MGM4OGRjLTJiN2ItNDE1Mi04MDIyLTc2YTFhMjg2ZGQwYSIsImlhdCI6MTU4MDcyMTEzNCwic3ViIjoiZGV2ZWxvcGVyLzUwMjIxMTE5LTczOTEtNDg4ZS0zMTIwLTk4Y2M2MGFjYjRiMCIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyI2Ny4yMDkuMTc3LjIzIiwiMTgwLjEyNy42Ny44OSJdLCJ0eXBlIjoiY2xpZW50In1dfQ.oQR2C32absDW4BMkCb-wWytTKsmR3TOF09LkI4qJP-exD-NPon4TPfelE-AqKVYsGWfoQDtjKn7mHQNLJYVBNw";

  static const String PREFIX_CHARACTER = '%23';

  static const String NO_CLAN_HOLDER_WHITE = "https://royaleapi.github.io/cr-api-assets/badges/NoClan.png";
  static const String NO_CLAN_HOLDER_BLACK = "https://royaleapi.github.io/cr-api-assets/badges/no_clan.png";
  static const String IMAGE_ASSET_BASE_URL = "https://royaleapi.github.io/cr-api-assets/";
  static const String IMAGE_ASSET_ARENAS   = "https://royaleapi.github.io/cr-api-assets/arenas/";
  static const String IMAGE_ASSET_BADGES   = "https://royaleapi.github.io/cr-api-assets/badges/";
  static const String IMAGE_ASSET_CHESTS   = "https://royaleapi.github.io/cr-api-assets/chests/";
  static const String IMAGE_PNG_FORMAT     = ".png";

  // 文件相关
  static const APP_FONT_DIRECTORY = '/fonts/';
  static const APP_DOWNLOAD_DIRECTORY = '/downloads/';
}