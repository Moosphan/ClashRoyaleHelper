// Copyright 2020 Moosphon. All rights reserved.
import 'package:royale_app/core/model/base/common_model.dart';

/// 当前游戏卡片数据
class AvailableCards {
  List<RoleCard> items;

  AvailableCards({this.items});

  AvailableCards.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<RoleCard>();
      json['items'].forEach((v) { items.add(new RoleCard.fromJson(v)); });
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