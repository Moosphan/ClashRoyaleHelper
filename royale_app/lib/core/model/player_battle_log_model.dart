// Copyright 2020 Moosphon. All rights reserved.
import 'common_model.dart';
/// 玩家对战记录信息
class PlayerBattleLog {
  String type;
  String battleTime;
  bool isLadderTournament;
  Arena arena;
  Arena gameMode;
  String deckSelection;
  List<PlayerBattle> team;
  List<PlayerBattle> opponent;

  // 是否胜利
  bool get won => team.first.crowns != 0;
  // 对战模式的名称
  String get battleTypeName => _convertBattleType();

  Map<String, String> battleTypes;
  Map<String, String> battleModes;

  void _init() {
    battleTypes = {
      'casual1v1': '1v1派对赛',
      'casual2v2': '2v2派对赛',
      'challenge': '挑战赛',
      'PvP': '天梯赛'
    };

    battleModes = {
      '72000062': '三倍圣水对战', //TripleElixir_Ladder
      '72000122': '', //Draft_Rage_SpawnJacks_Friendly
      '72000007': '好友切磋', //Friendly
      '72000023': '团队战', //TeamVsTeamLadder
    };
  }

  String _convertBattleType() {
    return battleTypes[type];
  }

  PlayerBattleLog(
      {this.type,
        this.battleTime,
        this.isLadderTournament,
        this.arena,
        this.gameMode,
        this.deckSelection,
        this.team,
        this.opponent});

  PlayerBattleLog.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    battleTime = json['battleTime'];
    isLadderTournament = json['isLadderTournament'];
    arena = json['arena'] != null ? new Arena.fromJson(json['arena']) : null;
    gameMode =
    json['gameMode'] != null ? new Arena.fromJson(json['gameMode']) : null;
    deckSelection = json['deckSelection'];
    if (json['team'] != null) {
      team = new List<PlayerBattle>();
      json['team'].forEach((v) {
        team.add(new PlayerBattle.fromJson(v));
      });
    }
    if (json['opponent'] != null) {
      opponent = new List<PlayerBattle>();
      json['opponent'].forEach((v) {
        opponent.add(new PlayerBattle.fromJson(v));
      });
    }
    // 初始化执行赛事名称任务
    _init();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['battleTime'] = this.battleTime;
    data['isLadderTournament'] = this.isLadderTournament;
    if (this.arena != null) {
      data['arena'] = this.arena.toJson();
    }
    if (this.gameMode != null) {
      data['gameMode'] = this.gameMode.toJson();
    }
    data['deckSelection'] = this.deckSelection;
    if (this.team != null) {
      data['team'] = this.team.map((v) => v.toJson()).toList();
    }
    if (this.opponent != null) {
      data['opponent'] = this.opponent.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayerBattle {
  String tag;
  String name;
  int startingTrophies;
  int trophyChange; // 奖杯变化（仅限于天梯赛）
  int crowns;
  int kingTowerHitPoints;
  //List<int> princessTowersHitPoints;
  Clan clan;
  List<RoleCard> cards;

  PlayerBattle(
      {this.tag,
        this.name,
        this.startingTrophies,
        this.trophyChange,
        this.crowns,
        this.kingTowerHitPoints,
        //this.princessTowersHitPoints,
        this.clan,
        this.cards});

  PlayerBattle.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    startingTrophies = json['startingTrophies'];
    trophyChange = json['trophyChange'];
    crowns = json['crowns'];
    kingTowerHitPoints = json['kingTowerHitPoints'];
    //princessTowersHitPoints = json['princessTowersHitPoints'];
    //princessTowersHitPoints = new List<int>();
    //json['princessTowersHitPoints'].forEach((v) { princessTowersHitPoints.add(v); });
    clan = json['clan'] != null ? new Clan.fromJson(json['clan']) : null;
    if (json['cards'] != null) {
      cards = new List<RoleCard>();
      json['cards'].forEach((v) {
        cards.add(new RoleCard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['startingTrophies'] = this.startingTrophies;
    data['trophyChange'] = this.trophyChange;
    data['crowns'] = this.crowns;
    data['kingTowerHitPoints'] = this.kingTowerHitPoints;
    //data['princessTowersHitPoints'] = this.princessTowersHitPoints;
    if (this.clan != null) {
      data['clan'] = this.clan.toJson();
    }
    if (this.cards != null) {
      data['cards'] = this.cards.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

