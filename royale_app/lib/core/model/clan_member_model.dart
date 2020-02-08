// Copyright 2020 Moosphon. All rights reserved.

/// 社团成员信息
class ClanMemberList {
  List<ClanMember> items;

  ClanMemberList({this.items});

  ClanMemberList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<ClanMember>();
      json['items'].forEach((v) { items.add(new ClanMember.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClanMember {
  String tag;
  String name;
  String role;
  String lastSeen;
  int expLevel;
  int trophies;
  Arena arena;
  int clanRank;
  int previousClanRank;
  int donations;
  int donationsReceived;
  int clanChestPoints;

  ClanMember({this.tag, this.name, this.role, this.lastSeen, this.expLevel, this.trophies, this.arena, this.clanRank, this.previousClanRank, this.donations, this.donationsReceived, this.clanChestPoints});

  ClanMember.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    role = json['role'];
    lastSeen = json['lastSeen'];
    expLevel = json['expLevel'];
    trophies = json['trophies'];
    arena = json['arena'] != null ? new Arena.fromJson(json['arena']) : null;
    clanRank = json['clanRank'];
    previousClanRank = json['previousClanRank'];
    donations = json['donations'];
    donationsReceived = json['donationsReceived'];
    clanChestPoints = json['clanChestPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['role'] = this.role;
    data['lastSeen'] = this.lastSeen;
    data['expLevel'] = this.expLevel;
    data['trophies'] = this.trophies;
    if (this.arena != null) {
      data['arena'] = this.arena.toJson();
    }
    data['clanRank'] = this.clanRank;
    data['previousClanRank'] = this.previousClanRank;
    data['donations'] = this.donations;
    data['donationsReceived'] = this.donationsReceived;
    data['clanChestPoints'] = this.clanChestPoints;
    return data;
  }
}

class Arena {
  int id;
  String name;

  Arena({this.id, this.name});

  Arena.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
