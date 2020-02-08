// Copyright 2020 Moosphon. All rights reserved.
import 'common_model.dart';

/// 玩家排行榜数据
class PlayerRank {
  List<TopPlayer> items;
  Paging paging;

  PlayerRank({this.items, this.paging});

  PlayerRank.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<TopPlayer>();
      json['items'].forEach((v) { items.add(new TopPlayer.fromJson(v)); });
    }
    paging = json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.paging != null) {
      data['paging'] = this.paging.toJson();
    }
    return data;
  }
}

class TopPlayer {
  String tag;
  String name;
  int expLevel;
  int trophies;
  int rank;
  int previousRank;
  Clan clan;
  Arena arena;

  TopPlayer({this.tag, this.name, this.expLevel, this.trophies, this.rank, this.previousRank, this.clan, this.arena});

  TopPlayer.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    expLevel = json['expLevel'];
    trophies = json['trophies'];
    rank = json['rank'];
    previousRank = json['previousRank'];
    clan = json['clan'] != null ? new Clan.fromJson(json['clan']) : null;
    arena = json['arena'] != null ? new Arena.fromJson(json['arena']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['expLevel'] = this.expLevel;
    data['trophies'] = this.trophies;
    data['rank'] = this.rank;
    data['previousRank'] = this.previousRank;
    if (this.clan != null) {
      data['clan'] = this.clan.toJson();
    }
    if (this.arena != null) {
      data['arena'] = this.arena.toJson();
    }
    return data;
  }
}

class Paging {
  Cursors cursors;

  Paging({this.cursors});

  Paging.fromJson(Map<String, dynamic> json) {
    cursors = json['cursors'] != null ? new Cursors.fromJson(json['cursors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cursors != null) {
      data['cursors'] = this.cursors.toJson();
    }
    return data;
  }
}

class Cursors {


  Cursors.fromJson(Map<String, dynamic> json) {
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

