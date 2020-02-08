// Copyright 2020 Moosphon. All rights reserved.

import 'package:flutter/material.dart';
import 'package:royale_app/core/model/common_model.dart';
import 'package:royale_app/core/resource/constants.dart';
import 'package:royale_app/generated/i18n.dart';

/// Game hidden data repository which official api has not provided.
/// Includes: chests assets, card information, arenas info, clan badges..
/// @author moosphon

class HiddenDataRepository {

  static HiddenDataRepository _instance;

  static HiddenDataRepository get current => _instance;

  static Map<String, String> _chests;
  static Map<String, ArenaImprovedData> _arenas;

  static Map<String, String> _clanRoles;

  static void init() {
    _instance = HiddenDataRepository();
    _initializeChestsData();
    _initializeArenasData();
  }

  static _initializeChestsData() {
    _chests = {
      'Silver Chest': 'chest-silver',
      'Golden Chest': 'chest-gold',
      'Magical Chest': 'chest-magical',
      'Epic Chest': 'chest-epic',
      'Legendary Chest': 'chest-legendary',
      'Mega Lightning Chest': 'chest-megalightning',
      'Giant Chest': 'chest-giant',
    };
  }

  // get chest image resource
  String findChest(String key) {
    return '${Constants.IMAGE_ASSET_CHESTS}${_chests[key]}${Constants.IMAGE_PNG_FORMAT}';
  }

  static _initializeArenasData() {
    _arenas = {
      //'54000001': 'arena0',
      '54000001': ArenaImprovedData('1阶竞技场', 'arena1'),
      '54000002': ArenaImprovedData('2阶竞技场', 'arena2'),
      '54000003': ArenaImprovedData('3阶竞技场', 'arena3'),
      '54000004': ArenaImprovedData('4阶竞技场', 'arena4'),
      '54000005': ArenaImprovedData('5阶竞技场', 'arena5'),
      '54000006': ArenaImprovedData('6阶竞技场', 'arena6'),
      '54000008': ArenaImprovedData('7阶竞技场', 'arena7'),
      '54000009': ArenaImprovedData('8阶竞技场', 'arena8'),
      '54000010': ArenaImprovedData('9阶竞技场', 'arena9'),
      '54000007': ArenaImprovedData('10阶竞技场', 'arena10'),
      '54000024': ArenaImprovedData('11阶竞技场', 'arena11'),
      '54000011': ArenaImprovedData('12阶竞技场', 'arena12'),
      '54000012': ArenaImprovedData('挑战者联赛I', 'arena13'),
      '54000013': ArenaImprovedData('挑战者联赛II', 'arena14'),
      '54000014': ArenaImprovedData('挑战者联赛III', 'arena15'),
      '54000015': ArenaImprovedData('大师联赛I', 'arena16'),
      '54000016': ArenaImprovedData('大师联赛II', 'arena17'),
      '54000017': ArenaImprovedData('大师联赛III', 'arena18'),
      '54000018': ArenaImprovedData('冠军联赛', 'arena19'),
      '54000019': ArenaImprovedData('超级冠军联赛', 'arena20'),
       // TODO: 新赛季刚开始，尚未有人达到，待完善～
      'Royal Champion': ArenaImprovedData('皇室冠军联赛', 'arena21'),
      'Ultimate Champion': ArenaImprovedData('终极冠军联赛', 'arena22'),

      'league1': ArenaImprovedData('1阶竞技场', 'league1'),
      'league2': ArenaImprovedData('1阶竞技场', 'league2'),
      'league3': ArenaImprovedData('1阶竞技场', 'league3'),
      'league4': ArenaImprovedData('1阶竞技场', 'league4'),
      'league5': ArenaImprovedData('1阶竞技场', 'league5'),
      'league6': ArenaImprovedData('1阶竞技场', 'league6'),
      'league7': ArenaImprovedData('1阶竞技场', 'league7'),
      'league8': ArenaImprovedData('1阶竞技场', 'league8'),
      'league9': ArenaImprovedData('1阶竞技场', 'league9'),
    };
  }

  // get arena resource
  ArenaImprovedData findArena(String id) {
    return _arenas[id];
  }

  static initializeClanRoleData(context) {
    _clanRoles = {
      'leader': S.of(context).roleLeader,
      'coLeader': S.of(context).roleCoLeader,
      'elder': S.of(context).roleElder,
      'member': S.of(context).roleMember
    };
  }

  // get clean roles
  // before get role, we should use #initializeClanRoleData first in #build method.
  String finClanRole(String key) {
    return _clanRoles[key];
  }





}