// Copyright 2020 Moosphon. All rights reserved.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:royale_app/core/pages/card/card_list_page.dart';
import 'package:royale_app/core/pages/home/clans_rank_page.dart';
import 'package:royale_app/core/pages/home/players_rank_page.dart';
import 'package:royale_app/core/resource/image_assets.dart';
import 'package:royale_app/core/resource/style.dart';
import 'package:royale_app/core/widget/bottom_nav_bar.dart';
import 'package:royale_app/core/widget/center_docked_fab.dart';

/// Home page
/// @author Moosphon
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  List<Widget> _pages = [
    PlayersRankPage(),
    ClansRankPage(),
    PlayersRankPage(),
    //PlayersRankPage(),
    CardListPage()
  ];
  List<TimeoryBottomNavItem> tabs;
  int _currentIndex = 0;

  @override
  void initState() {
    /// adapt for status bar to white
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.light));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    tabs = [
      TimeoryBottomNavItem(
          title: 'Players',
          selectedIcon: ImageAssets.ic_nav_player_rank,
          unselectedIcon: ImageAssets.ic_nav_players_normal
      ),
      TimeoryBottomNavItem(
          title: 'Clans',
          selectedIcon: ImageAssets.ic_nav_clan_rank,
          unselectedIcon: ImageAssets.ic_nav_clans_normal,
      ),
      TimeoryBottomNavItem(
          title: 'Matches',
          selectedIcon: ImageAssets.ic_nav_tournament_rank,
          unselectedIcon: ImageAssets.ic_nav_tournament_normal
      ),
//      TimeoryBottomNavItem(
//          title: 'News',
//          selectedIcon: ImageAssets.ic_nav_news,
//          unselectedIcon: ImageAssets.ic_nav_news_normal
//      ),
      TimeoryBottomNavItem(
          title: 'Cards',
          selectedIcon: ImageAssets.ic_nav_cards,
          unselectedIcon: ImageAssets.ic_nav_cards_normal
      ),
    ];
    return Scaffold(
//      body: IndexedStack(
//        index: _currentIndex,
//        children: _pages,
//      ),
      body: _pages[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: TimeoryCenterDockedFab(
        icon: ImageAssets.ic_write_letter,
        color: AppTheme.primaryColor,
        onFabPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Placeholder())
          );
        },
      ),
      bottomNavigationBar: TimeoryBottomNavigationBar(
        items: tabs,
        centerWidth: 66,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      )
    );
  }

  @override
  bool get wantKeepAlive => true;

}