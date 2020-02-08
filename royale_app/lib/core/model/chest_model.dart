// Copyright 2020 Moosphon. All rights reserved.
/// @author moosphon
/// 玩家未来奖励宝箱数据
class ChestList {
  List<Chest> items;

  ChestList({this.items});

  ChestList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Chest>();
      json['items'].forEach((v) {
        items.add(new Chest.fromJson(v));
      });
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

class Chest {
  int index;
  String name;

  Chest({this.index, this.name});

  Chest.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['name'] = this.name;
    return data;
  }
}