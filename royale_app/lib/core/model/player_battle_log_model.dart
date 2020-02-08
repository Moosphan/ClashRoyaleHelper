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
  int crowns;
  int kingTowerHitPoints;
  List<int> princessTowersHitPoints;
  Clan clan;
  List<RoleCard> cards;

  PlayerBattle(
      {this.tag,
        this.name,
        this.startingTrophies,
        this.crowns,
        this.kingTowerHitPoints,
        this.princessTowersHitPoints,
        this.clan,
        this.cards});

  PlayerBattle.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    startingTrophies = json['startingTrophies'];
    crowns = json['crowns'];
    kingTowerHitPoints = json['kingTowerHitPoints'];
    princessTowersHitPoints = json['princessTowersHitPoints'].cast<int>();
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
    data['crowns'] = this.crowns;
    data['kingTowerHitPoints'] = this.kingTowerHitPoints;
    data['princessTowersHitPoints'] = this.princessTowersHitPoints;
    if (this.clan != null) {
      data['clan'] = this.clan.toJson();
    }
    if (this.cards != null) {
      data['cards'] = this.cards.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

