// Copyright 2020 Moosphon. All rights reserved.
/// 顶级部落数据
class ClansRank {
  List<TopClan> items;

  ClansRank({this.items});

  ClansRank.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<TopClan>();
      json['items'].forEach((v) { items.add(new TopClan.fromJson(v)); });
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

class TopClan {
  String tag;
  String name;
  int rank;
  int previousRank;
  Location location;
  int clanScore;
  int members;
  int badgeId;

  TopClan({this.tag, this.name, this.rank, this.previousRank, this.location, this.clanScore, this.members, this.badgeId});

  TopClan.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    rank = json['rank'];
    previousRank = json['previousRank'];
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
    clanScore = json['clanScore'];
    members = json['members'];
    badgeId = json['badgeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['rank'] = this.rank;
    data['previousRank'] = this.previousRank;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['clanScore'] = this.clanScore;
    data['members'] = this.members;
    data['badgeId'] = this.badgeId;
    return data;
  }
}

class Location {
  int id;
  String name;
  bool isCountry;
  String countryCode;

  Location({this.id, this.name, this.isCountry, this.countryCode});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isCountry = json['isCountry'];
    countryCode = json['countryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isCountry'] = this.isCountry;
    data['countryCode'] = this.countryCode;
    return data;
  }
}
