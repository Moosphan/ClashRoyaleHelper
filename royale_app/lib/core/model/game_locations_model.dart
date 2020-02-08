// Copyright 2020 Moosphon. All rights reserved.

/// World areas of Game.
class GameLocations {
  List<Location> items;

  GameLocations({this.items});

  GameLocations.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Location>();
      json['items'].forEach((v) { items.add(new Location.fromJson(v)); });
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