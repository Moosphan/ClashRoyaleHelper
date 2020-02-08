// Copyright 2020 Moosphon. All rights reserved.
import 'common_model.dart';

/// 玩家的详细数据
/// @author Moosphon
class PlayerDetail {
  String tag;
  String name;
  int expLevel;                                 // 等级
  int trophies;                                 // 奖杯
  int bestTrophies;                             // 最佳奖杯
  int wins;                                     // 胜场
  int losses;                                   // 败绩
  int battleCount;                              // 对局数量
  int threeCrownWins;                           // 三杯战绩
  int challengeCardsWon;                        // 挑战胜场
  int challengeMaxWins;                         // 单次挑战最多胜场
  int tournamentCardsWon;                       // 锦标赛胜场
  int tournamentBattleCount;                    // 锦标赛对局数量
  String role;                                  // 身份
  int donations;                                // 当前部落捐献数
  int donationsReceived;                        // 当前部落获得捐献数
  int totalDonations;                           // 生涯累计捐献
  int warDayWins;                               // 部落战胜场
  int clanCardsCollected;                       // 累计收到部落捐献的卡片数
  Clan clan;                                    // 简要部落数据
  Arena arena;                                  // 简要竞技场数据
  LeagueStatistics leagueStatistics;            // 数据统计
  List<Badge> badges;                           // 生涯徽章
  List<Achievement> achievements;               // 生涯成就
  List<RoleCard> cards;                         // 拥有的卡片
  List<RoleCard> currentDeck;                   // 当前装备卡组
  CurrentFavouriteCard currentFavouriteCard;    // 当前最爱卡片
  int starPoints;                               // 积分

  PlayerDetail(
      {this.tag,
        this.name,
        this.expLevel,
        this.trophies,
        this.bestTrophies,
        this.wins,
        this.losses,
        this.battleCount,
        this.threeCrownWins,
        this.challengeCardsWon,
        this.challengeMaxWins,
        this.tournamentCardsWon,
        this.tournamentBattleCount,
        this.role,
        this.donations,
        this.donationsReceived,
        this.totalDonations,
        this.warDayWins,
        this.clanCardsCollected,
        this.clan,
        this.arena,
        this.leagueStatistics,
        this.badges,
        this.achievements,
        this.cards,
        this.currentDeck,
        this.currentFavouriteCard,
        this.starPoints});

  PlayerDetail.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    expLevel = json['expLevel'];
    trophies = json['trophies'];
    bestTrophies = json['bestTrophies'];
    wins = json['wins'];
    losses = json['losses'];
    battleCount = json['battleCount'];
    threeCrownWins = json['threeCrownWins'];
    challengeCardsWon = json['challengeCardsWon'];
    challengeMaxWins = json['challengeMaxWins'];
    tournamentCardsWon = json['tournamentCardsWon'];
    tournamentBattleCount = json['tournamentBattleCount'];
    role = json['role'];
    donations = json['donations'];
    donationsReceived = json['donationsReceived'];
    totalDonations = json['totalDonations'];
    warDayWins = json['warDayWins'];
    clanCardsCollected = json['clanCardsCollected'];
    clan = json['clan'] != null ? new Clan.fromJson(json['clan']) : null;
    arena = json['arena'] != null ? new Arena.fromJson(json['arena']) : null;
    leagueStatistics = json['leagueStatistics'] != null
        ? new LeagueStatistics.fromJson(json['leagueStatistics'])
        : null;
    if (json['badges'] != null) {
      badges = new List<Badge>();
      json['badges'].forEach((v) {
        badges.add(new Badge.fromJson(v));
      });
    }
    if (json['achievements'] != null) {
      achievements = new List<Achievement>();
      json['achievements'].forEach((v) {
        achievements.add(new Achievement.fromJson(v));
      });
    }
    if (json['cards'] != null) {
      cards = new List<RoleCard>();
      json['cards'].forEach((v) {
        cards.add(new RoleCard.fromJson(v));
      });
    }
    if (json['currentDeck'] != null) {
      currentDeck = new List<RoleCard>();
      json['currentDeck'].forEach((v) {
        currentDeck.add(new RoleCard.fromJson(v));
      });
    }
    currentFavouriteCard = json['currentFavouriteCard'] != null
        ? new CurrentFavouriteCard.fromJson(json['currentFavouriteCard'])
        : null;
    starPoints = json['starPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['expLevel'] = this.expLevel;
    data['trophies'] = this.trophies;
    data['bestTrophies'] = this.bestTrophies;
    data['wins'] = this.wins;
    data['losses'] = this.losses;
    data['battleCount'] = this.battleCount;
    data['threeCrownWins'] = this.threeCrownWins;
    data['challengeCardsWon'] = this.challengeCardsWon;
    data['challengeMaxWins'] = this.challengeMaxWins;
    data['tournamentCardsWon'] = this.tournamentCardsWon;
    data['tournamentBattleCount'] = this.tournamentBattleCount;
    data['role'] = this.role;
    data['donations'] = this.donations;
    data['donationsReceived'] = this.donationsReceived;
    data['totalDonations'] = this.totalDonations;
    data['warDayWins'] = this.warDayWins;
    data['clanCardsCollected'] = this.clanCardsCollected;
    if (this.clan != null) {
      data['clan'] = this.clan.toJson();
    }
    if (this.arena != null) {
      data['arena'] = this.arena.toJson();
    }
    if (this.leagueStatistics != null) {
      data['leagueStatistics'] = this.leagueStatistics.toJson();
    }
    if (this.badges != null) {
      data['badges'] = this.badges.map((v) => v.toJson()).toList();
    }
    if (this.achievements != null) {
      data['achievements'] = this.achievements.map((v) => v.toJson()).toList();
    }
    if (this.cards != null) {
      data['cards'] = this.cards.map((v) => v.toJson()).toList();
    }
    if (this.currentDeck != null) {
      data['currentDeck'] = this.currentDeck.map((v) => v.toJson()).toList();
    }
    if (this.currentFavouriteCard != null) {
      data['currentFavouriteCard'] = this.currentFavouriteCard.toJson();
    }
    data['starPoints'] = this.starPoints;
    return data;
  }
}

class LeagueStatistics {
  CurrentSeason currentSeason;
  BestSeason bestSeason;

  LeagueStatistics({this.currentSeason, this.bestSeason});

  LeagueStatistics.fromJson(Map<String, dynamic> json) {
    currentSeason = json['currentSeason'] != null
        ? new CurrentSeason.fromJson(json['currentSeason'])
        : null;
    bestSeason = json['bestSeason'] != null
        ? new BestSeason.fromJson(json['bestSeason'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentSeason != null) {
      data['currentSeason'] = this.currentSeason.toJson();
    }
    if (this.bestSeason != null) {
      data['bestSeason'] = this.bestSeason.toJson();
    }
    return data;
  }
}

class CurrentSeason {
  int rank;
  int trophies;
  int bestTrophies;

  CurrentSeason({this.rank, this.trophies, this.bestTrophies});

  CurrentSeason.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    trophies = json['trophies'];
    bestTrophies = json['bestTrophies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    data['trophies'] = this.trophies;
    data['bestTrophies'] = this.bestTrophies;
    return data;
  }
}

class BestSeason {
  String id;
  int rank;
  int trophies;

  BestSeason({this.id, this.rank, this.trophies});

  BestSeason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['rank'];
    trophies = json['trophies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rank'] = this.rank;
    data['trophies'] = this.trophies;
    return data;
  }
}

class Badge {
  String name;
  int level;
  int maxLevel;
  int progress;
  int target;

  Badge({this.name, this.level, this.maxLevel, this.progress, this.target});

  Badge.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    level = json['level'];
    maxLevel = json['maxLevel'];
    progress = json['progress'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['level'] = this.level;
    data['maxLevel'] = this.maxLevel;
    data['progress'] = this.progress;
    data['target'] = this.target;
    return data;
  }
}

class Achievement {
  String name;
  int stars;
  int value;
  int target;
  String info;
  Null completionInfo;

  Achievement(
      {this.name,
        this.stars,
        this.value,
        this.target,
        this.info,
        this.completionInfo});

  Achievement.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    stars = json['stars'];
    value = json['value'];
    target = json['target'];
    info = json['info'];
    completionInfo = json['completionInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['stars'] = this.stars;
    data['value'] = this.value;
    data['target'] = this.target;
    data['info'] = this.info;
    data['completionInfo'] = this.completionInfo;
    return data;
  }
}

class CurrentFavouriteCard {
  String name;
  int id;
  int maxLevel;
  IconUrl iconUrls;

  CurrentFavouriteCard({this.name, this.id, this.maxLevel, this.iconUrls});

  CurrentFavouriteCard.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    maxLevel = json['maxLevel'];
    iconUrls = json['iconUrls'] != null
        ? new IconUrl.fromJson(json['iconUrls'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['maxLevel'] = this.maxLevel;
    if (this.iconUrls != null) {
      data['iconUrls'] = this.iconUrls.toJson();
    }
    return data;
  }
}