// Copyright 2020 Moosphon. All rights reserved.
/// 部落徽章数据
/// From: https://github.com/RoyaleAPI/cr-api-data/blob/master/json/alliance_badges.json
/// icon e.g. https://royaleapi.github.io/cr-api-assets/badges/A_Char_Rocket_02.png
class BadgeIconData {
  String name;           // icon name we needed
  String iconSwf;
  String iconExportName;
  String category;
  int id;

  BadgeIconData(
      {this.name, this.iconSwf, this.iconExportName, this.category, this.id});

  BadgeIconData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iconSwf = json['icon_swf'];
    iconExportName = json['icon_export_name'];
    category = json['category'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon_swf'] = this.iconSwf;
    data['icon_export_name'] = this.iconExportName;
    data['category'] = this.category;
    data['id'] = this.id;
    return data;
  }
}