// Copyright 2020 Moosphon. All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:royale_app/core/model/game_locations_model.dart';
import 'package:royale_app/core/model/top_players_model.dart';
import 'package:royale_app/core/pages/location/location_list_page.dart';
import 'package:royale_app/core/pages/player/player_detail_page.dart';
import 'package:royale_app/core/provider/extension/partial_consumer_widget.dart';
import 'package:royale_app/core/resource/image_assets.dart';
import 'package:royale_app/core/resource/style.dart';
import 'package:royale_app/core/util/screen_adapt.dart';
import 'package:royale_app/core/util/screen_utils.dart';
import 'package:royale_app/core/viewmodel/rank_vm.dart';
import 'package:royale_app/core/widget/common_progress_indicator.dart';
import 'package:royale_app/generated/i18n.dart';

/// The page that receives letters.
/// @author Moosphon
class PlayersRankPage extends StatefulWidget {
  @override
  _PlayersRankPageState createState() => _PlayersRankPageState();
}

class _PlayersRankPageState extends State<PlayersRankPage> {

  PlayerRank _topPlayerList;
  RankViewModel _rankViewModel;

  bool get _isEmpty => _topPlayerList.items == null || _topPlayerList.items.length == 0;

  String _area;


  @override
  void initState() {
    _rankViewModel = RankViewModel();
    _rankViewModel.getPlayerRank(country: '57000056').then((result) {
      _topPlayerList = result;
      setState(() {

      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: AppTheme.surfaceColor,
          child: PartialConsumeComponent<RankViewModel>(
            model: _rankViewModel,
            builder: (context, model, _) =>
            /// TODO: add error state
            Column(
              children: <Widget>[
                // customized app bar
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withAlpha(20),
                              blurRadius: 1,
                              offset: Offset(0, 1),
                              spreadRadius: -1
                          )
                        ]
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ScreenUtils.horizontalSpace(12),
                                Image(
                                    width: 20,
                                    height: 20,
                                    image: AssetImage(ImageAssets.ic_penfriend)
                                ),
                                ScreenUtils.horizontalSpace(6),
                                Text('${_topPlayerList == null ? '0' : _topPlayerList.items.length.toString()}/1000',
                                    style: AppTheme.body2.copyWith(color: AppTheme.textHintColor)
                                )
                              ],
                            ),
                            IconButton(
                                icon: ImageIcon(
                                    AssetImage(ImageAssets.ic_player_profile)
                                ),
                                iconSize: 24,
                                onPressed: () {
                                  Fluttertoast.showToast(msg: '绑定个人游戏账号');
                                }
                            )
                          ],
                        ),

                        // title
                        Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    S.of(context).playerRankTopPlayerTitle,
                                    style: AppTheme.title,
                                  ),
                                  ScreenUtils.verticalSpace(2),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push<Location>(
                                          MaterialPageRoute(builder: (context) => LocationListPage())
                                      ).then((result) {
                                        if (result != null) {
                                          Fluttertoast.showToast(msg: result.name);
                                          _area = result.name;
                                          _refreshData(result.id.toString());
                                        }
                                      });
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          _area ?? '中国',
                                          style: AppTheme.micro,
                                        ),
                                        ScreenUtils.horizontalSpace(6),
                                        Icon(Icons.arrow_drop_down, size: 16)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                      ],
                    )
                ),
                Expanded(
                  child: _buildContentView(model),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentView(RankViewModel model) {
    if (model.isLoading) {
      return _buildLoadingHolder();
    } else if (_topPlayerList == null || _topPlayerList.items == null || model.isEmpty ) {
      return _buildEmptyHolder();
    } else {
      return ListView.builder(
          itemCount: _topPlayerList.items.length,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 8),
          itemBuilder: (context, index) => _buildUserCard(index)
      );
    }
  }


  Widget _buildUserCard(index) =>
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PlayerDetailPage(tag: _topPlayerList.items[index].tag))
          );
        },
        child: Container(
          height: AutoSize.covert.dpToDp(70),
          padding: EdgeInsets.only(left: AutoSize.covert.dpToDp(16)),
          decoration: BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.all(Radius.circular(12)),
              border: Border(
                bottom: BorderSide(color: AppTheme.borderColor, width: 1)
              )
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: AutoSize.covert.dpToDp(48),
                height: AutoSize.covert.dpToDp(56),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.holder_clan),
                  )
                ),
                child: Text(
                  _topPlayerList.items[index].rank.toString(),
                  style: _buildRankTextStyle(index),
                ),
              ),
              ScreenUtils.horizontalSpace(AutoSize.covert.dpToDp(6)),
//            RoundedAvatar(
//              imageResource: ImageAssets.avatar_default,
//              width: AutoSize.covert.dpToDp(40),
//              height: AutoSize.covert.dpToDp(40),
//              borderColor: Colors.transparent,
//            ),
              Expanded(
                child: Container(
                  constraints: BoxConstraints.expand(),
                  margin: EdgeInsets.symmetric(horizontal: AutoSize.covert.dpToDp(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(_isEmpty
                                ? S.of(context).unknownText
                                : _topPlayerList.items[index].name,
                              style: AppTheme.body1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                          ScreenUtils.horizontalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImageAssets.ic_cr_tower_level),
                              )
                            ),
                            child: Text(_topPlayerList.items[index].expLevel.toString(),
                                style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)
                            ),
                          )
                        ],
                      ),
                      ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(10)),
                      Text(
                        _isEmpty || _topPlayerList.items[index].clan == null
                            ? S.of(context).unknownText
                            : _topPlayerList.items[index].clan.name,
                        style: AppTheme.small,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: AutoSize.covert.dpToDp(12)),
                child: InkWell(
                  onTap: _isEmpty ? null : () {

                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          width: AutoSize.covert.dpToDp(22),
                          height: AutoSize.covert.dpToDp(22),
                          image: AssetImage(ImageAssets.ic_cr_cups)
                      ),
                      ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                      Text(_topPlayerList.items[index].trophies.toString(),
                        style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildLoadingHolder() =>
      Center(
        child: CommonProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      );

  Widget _buildEmptyHolder() =>
      Center(
        child: Image(
          width: AutoSize.covert.dpToDp(126),
          height: AutoSize.covert.dpToDp(105),
          image: AssetImage(ImageAssets.ic_empty_search),
        ),
      );

  TextStyle _buildRankTextStyle(index) {
    if (index == 0 || index == 1 || index == 2) {
      return TextStyle(
        color: _buildRankColor(index),
        fontSize: 24,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold
      );
    } else {
      return AppTheme.body1.copyWith(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,);
    }
  }

  Color _buildRankColor(index) {
    if (index == 0) {
      return Color(0xFFF16E58);
    } else if (index == 1) {
      return Color(0xFFF78141);
    } else if (index == 2) {
      return Color(0xFFF7BA41);
    } else {
      return AppTheme.primaryColor;
    }
  }

  _refreshData(String code) {
    _rankViewModel.getPlayerRank(country: code).then((result) {
      _topPlayerList = result;
      setState(() {
      });
    });
  }
}

