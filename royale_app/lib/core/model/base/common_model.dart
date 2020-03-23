
/// 玩家的部落简要信息，详细信息见[ClanDetail]
class Clan {
  String tag;
  String name;
  int badgeId;

  Clan({this.tag, this.name, this.badgeId});

  Clan.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    badgeId = json['badgeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['badgeId'] = this.badgeId;
    return data;
  }
}

/// 部落徽章信息
class Badge {

  String name;
  String category;
  int id;
  String image;

  Badge.fromJson(Map<String, dynamic> json) :
      name     = json['name'],
      category = json['category'],
      id       = json['id'],
      image    = json['image'];

  Map<String, dynamic> toJson() => {
    "name"      : name,
    "category"  : category,
    "id"        : id,
    "image"     : image
  };

  @override
  String toString() {
    return 'Badge{name: $name, category: $category, id: $id, image: $image}';
  }

}

/// 玩家竞技场简要信息
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
/// 卡片信息
class RoleCard {
  String name;
  int id;
  int level;
  int maxLevel;
  int count;
  IconUrl iconUrls;
  int starLevel;

  RoleCard(
      {this.name,
        this.id,
        this.level,
        this.maxLevel,
        this.count,
        this.iconUrls,
        this.starLevel});

  RoleCard.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    level = json['level'];
    maxLevel = json['maxLevel'];
    count = json['count'];
    iconUrls = json['iconUrls'] != null
        ? new IconUrl.fromJson(json['iconUrls'])
        : null;
    starLevel = json['starLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['level'] = this.level;
    data['maxLevel'] = this.maxLevel;
    data['count'] = this.count;
    if (this.iconUrls != null) {
      data['iconUrls'] = this.iconUrls.toJson();
    }
    data['starLevel'] = this.starLevel;
    return data;
  }
}
/// 卡组的图片信息
class IconUrl {
  String medium;

  IconUrl({this.medium});

  IconUrl.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medium'] = this.medium;
    return data;
  }
}
/// 补充的竞技场信息[图片和中文名称]
class ArenaImprovedData {
  String arenaNameCN;
  String arenaImage;

  ArenaImprovedData(this.arenaNameCN, this.arenaImage);
}