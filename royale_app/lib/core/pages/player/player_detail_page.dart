// Copyright 2020 Moosphon. All rights reserved.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:royale_app/core/model/chest_model.dart';
import 'package:royale_app/core/provider/extension/partial_consumer_widget.dart';
import 'package:royale_app/core/resource/constants.dart';
import 'package:royale_app/core/resource/image_assets.dart';
import 'package:royale_app/core/resource/style.dart';
import 'package:royale_app/core/service/hidden_repository.dart';
import 'package:royale_app/core/util/screen_adapt.dart';
import 'package:royale_app/core/util/screen_utils.dart';
import 'package:royale_app/core/viewmodel/player_viewmodel.dart';
import 'package:royale_app/core/widget/common_progress_indicator.dart';
import 'package:royale_app/generated/i18n.dart';
/// 玩家详情页面
class PlayerDetailPage extends StatefulWidget {

  final String tag;

  PlayerDetailPage({this.tag});

  @override
  _PlayerDetailPageState createState() => _PlayerDetailPageState();
}

class _PlayerDetailPageState extends State<PlayerDetailPage> {

  PlayerViewModel _playerViewModel;


  @override
  void initState() {
    // Base64Codec.urlSafe().encode(utf8.encode(widget.tag))
    HiddenDataRepository.init();
    _playerViewModel = PlayerViewModel();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    HiddenDataRepository.initializeClanRoleData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('玩家详情', style: AppTheme.title,),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.6,
        leading: IconButton(
            icon: ImageIcon(AssetImage(ImageAssets.ic_arrow_back), color: AppTheme.primaryColor),
            onPressed: () {
              Navigator.maybePop(context);
            }
        ),
        actions: <Widget>[
          IconButton(
              icon: ImageIcon(AssetImage(ImageAssets.ic_add_circle), color: AppTheme.primaryColor),
              onPressed: () {
                Fluttertoast.showToast(msg: '收藏');
              }
          )
        ],
      ),

      body: Container(
        child: PartialConsumeComponent<PlayerViewModel>(
          model: _playerViewModel,
          initialize: (model) {
            model.getPlayerDetail('${Constants.PREFIX_CHARACTER}${widget.tag.replaceFirst('#', '')}').then((result) {

            });
          },
          builder: (context, model, _) => model.isLoading || model.playerDetail == null ? _buildLoadingHolder() : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Row(
                    children: <Widget>[
                      Image(
                        width: 30,
                        height: 35,
                        image: AssetImage(ImageAssets.holder_clan),
                      ),
                      ScreenUtils.horizontalSpace(AutoSize.covert.dpToDp(6)),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: AutoSize.covert.dpToDp(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(model.playerDetail.name,
                                      style: AppTheme.body1.copyWith(fontWeight: FontWeight.w600),
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
                                    child: Text(model.playerDetail.expLevel.toString(),
                                        style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)
                                    ),
                                  )
                                ],
                              ),
                              ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(10)),
                              Row(
                                children: <Widget>[
                                  Text(
                                    model.playerDetail.clan.name,
                                    style: AppTheme.smallDark,
                                  ),
                                  ScreenUtils.horizontalSpace(4),
                                  Text('[${HiddenDataRepository.current.finClanRole(model.playerDetail.role)}]', style: AppTheme.small,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('${S.of(context).playerDetailTag}: ${model.playerDetail.tag}', style: AppTheme.small),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppTheme.surfaceColor
                            ),
                            child: Text(S.of(context).playerDetailClickCopy,
                              style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // 宝箱
                _buildFutureChestsArea(model),
                // 基本信息
                _buildBasicInfoArea(model),
                // 部落战简要信息
                _buildBriefClanWarArea(model),
                // 挑战赛数据
                _buildChallengeRecordArea(model),
                // 锦标赛数据
                _buildTournamentRecordArea(model),
                // 卡牌信息
                _buildCardsArea(model),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoArea(PlayerViewModel model) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image(image: AssetImage(ImageAssets.ic_left_header), width: 3, height: 10,),
              ScreenUtils.horizontalSpace(6),
              Text(S.of(context).playerDetailBasicInfo, style: AppTheme.smallDark.copyWith(fontWeight: FontWeight.bold),)
            ],
          ),
          ScreenUtils.verticalSpace(10),
          ScreenUtils.divider(0),
          ScreenUtils.verticalSpace(20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        width: AutoSize.covert.dpToDp(22),
                        height: AutoSize.covert.dpToDp(22),
                        image: AssetImage(ImageAssets.ic_cr_cups)
                    ),
                    ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                    Text(model.playerDetail.trophies.toString(),
                      style: AppTheme.smallDark.copyWith(fontWeight: FontWeight.bold),
                    ),
                    ScreenUtils.verticalSpace(6),
                    Text(S.of(context).playerDetailCurrentTrophies,
                      style: AppTheme.micro.copyWith(color: AppTheme.textHintColor),
                    )
                  ],
                ),
                ScreenUtils.horizontalSpace(26),

                Column(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: Constants.IMAGE_ASSET_ARENAS
                        + HiddenDataRepository.current.findArena(model.playerDetail.arena.id.toString()).arenaImage
                        + Constants.IMAGE_PNG_FORMAT,
                      height: 90,
                    ),
                    ScreenUtils.verticalSpace(12),
                    Text(
                      HiddenDataRepository.current.findArena(model.playerDetail.arena.id.toString()).arenaNameCN,
                      style: AppTheme.smallDark.copyWith(fontWeight: FontWeight.w800),
                    )
                  ],
                ),
                ScreenUtils.horizontalSpace(26),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        width: AutoSize.covert.dpToDp(22),
                        height: AutoSize.covert.dpToDp(22),
                        image: AssetImage(ImageAssets.ic_cr_cups)
                    ),
                    ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                    Text(model.playerDetail.bestTrophies.toString(),
                      style: AppTheme.smallDark.copyWith(fontWeight: FontWeight.bold),
                    ),
                    ScreenUtils.verticalSpace(6),
                    Text(S.of(context).playerDetailHighestTrophies,
                      style: AppTheme.micro.copyWith(color: AppTheme.textHintColor),
                    )
                  ],
                ),
              ],
            ),
          ),
          ScreenUtils.verticalSpace(10),
          //ScreenUtils.divider(0),
          ScreenUtils.verticalSpace(18),
          // 数据统计
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailWins,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppTheme.chipColor.withOpacity(0.48),
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(model.playerDetail.wins.toString(),
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailWinRate,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(
                              '${_getWinRate(model)}%',
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 3,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailThreeCrownWins,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(model.playerDetail.threeCrownWins.toString(),
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 2,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailCollectedCards,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text('${model.playerDetail.cards.length.toString()}/97',
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 3,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailTotalDonations,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(model.playerDetail.donations.toString(),
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 2,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailCurrentFavoriteCard,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(model.playerDetail.currentFavouriteCard.name,
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 3,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFutureChestsArea(model) => Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    padding: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4)
    ),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image(image: AssetImage(ImageAssets.ic_left_header), width: 3, height: 12,),
            ScreenUtils.horizontalSpace(6),
            Text(S.of(context).playerDetailUpcomingChests, style: AppTheme.smallDark.copyWith(fontWeight: FontWeight.bold),)
          ],
        ),
        ScreenUtils.verticalSpace(10),
        ScreenUtils.divider(0),
        ScreenUtils.verticalSpace(10),
        _buildChestList(model)
      ],
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

  Widget _buildChestList(PlayerViewModel model) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: model.chestList.items.length,
      padding: EdgeInsets.symmetric(horizontal: AutoSize.covert.dpToDp(6), vertical: AutoSize.covert.dpToDp(6)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: AutoSize.covert.dpToDp(5),
          mainAxisSpacing: AutoSize.covert.dpToDp(6),
          childAspectRatio: 0.96
      ),
      itemBuilder: (context, index) => _buildChestItem(model.chestList, index),
    );
  }

  Widget _buildChestItem(ChestList chestList, int index) {
    return Container(
      child: Container(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            CachedNetworkImage(imageUrl: HiddenDataRepository.current.findChest(chestList.items[index].name)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  index == 0
                      ? S.of(context).playerDetailNext
                      : '+' + chestList.items[index].index.toString(),
                  style: AppTheme.micro.copyWith(color: Colors.white, fontWeight: FontWeight.w800)
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getWinRate(PlayerViewModel model) {
    double total = model.playerDetail.losses.toDouble() + model.playerDetail.wins.toDouble();
    return ((model.playerDetail.wins/total*100).toInt()).toString();
  }

  Widget _buildBriefClanWarArea(PlayerViewModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image(image: AssetImage(ImageAssets.ic_left_header), width: 3, height: 12,),
              ScreenUtils.horizontalSpace(6),
              Expanded(child: Text(S.of(context).playerDetailClanWarStats, style: AppTheme.smallDark.copyWith(fontWeight: FontWeight.bold),)),
              GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(msg: '查看部落详情');
                },
                child: Row(
                  children: <Widget>[
                    Text(S.of(context).scanMore, style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor)),
                    ScreenUtils.horizontalSpace(3),
                    Icon(Icons.arrow_forward_ios, size: 8),
                    ScreenUtils.horizontalSpace(12)
                  ],
                ),
              )
            ],
          ),
          ScreenUtils.verticalSpace(10),
          ScreenUtils.divider(0),
          ScreenUtils.verticalSpace(10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailWarDayWins,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(model.playerDetail.warDayWins.toString(),
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 2,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailClanCardsCollected,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(model.playerDetail.clanCardsCollected.toString(),
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 3,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChallengeRecordArea(PlayerViewModel model) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image(image: AssetImage(ImageAssets.ic_left_header), width: 3, height: 12,),
              ScreenUtils.horizontalSpace(6),
              Text(S.of(context).playerDetailChallengeStats, style: AppTheme.smallDark.copyWith(fontWeight: FontWeight.bold),),

            ],
          ),
          ScreenUtils.verticalSpace(10),
          ScreenUtils.divider(0),
          ScreenUtils.verticalSpace(10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailMaxWins,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(model.playerDetail.challengeMaxWins.toString(),
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 2,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailCardWins,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(model.playerDetail.challengeCardsWon.toString(),
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 3,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget _buildTournamentRecordArea(PlayerViewModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image(image: AssetImage(ImageAssets.ic_left_header), width: 3, height: 12,),
              ScreenUtils.horizontalSpace(6),
              Text(S.of(context).playerDetailTournamentStats, style: AppTheme.smallDark.copyWith(fontWeight: FontWeight.bold),),
            ],
          ),
          ScreenUtils.verticalSpace(10),
          ScreenUtils.divider(0),
          ScreenUtils.verticalSpace(10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailTournamentTimes,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(model.playerDetail.tournamentBattleCount.toString(),
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 2,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(S.of(context).playerDetailTournamentWins,
                            style: AppTheme.micro.copyWith(color: AppTheme.textSecondaryColor),
                          ),
                          ScreenUtils.verticalSpace(AutoSize.covert.dpToDp(6)),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppTheme.chipColor.withOpacity(0.48),
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: AppTheme.borderColor, width: 0.7)
                            ),
                            child: Text(model.playerDetail.tournamentCardsWon.toString(),
                              style: AppTheme.smallDark.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 3,
                                        offset: Offset(0.5, 0.5)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCardsArea(PlayerViewModel model) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image(image: AssetImage(ImageAssets.ic_left_header), width: 3, height: 12),
              ScreenUtils.horizontalSpace(6),
              Text(S.of(context).playerDetailCardsStats, style: AppTheme.smallDark.copyWith(fontWeight: FontWeight.bold),),
            ],
          ),
          ScreenUtils.verticalSpace(10),
          ScreenUtils.divider(0),
          ScreenUtils.verticalSpace(18),
          // 当前使用的卡组
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
                color: AppTheme.chipColor,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(15))
            ),
            child: Text(S.of(context).playerDetailCurrentDeck, style: AppTheme.smallDark.copyWith(color: Colors.white)),
          ),

          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.playerDetail.currentDeck.length,
            padding: EdgeInsets.symmetric(horizontal: AutoSize.covert.dpToDp(6), vertical: AutoSize.covert.dpToDp(12)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: AutoSize.covert.dpToDp(6),
                mainAxisSpacing: AutoSize.covert.dpToDp(6),
                childAspectRatio: 0.82
            ),
            itemBuilder: (context, index) => Container(
              constraints: BoxConstraints.expand(),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                      imageUrl: model.playerDetail.currentDeck[index].iconUrls.medium
                  ),
                  Text('${model.playerDetail.currentDeck[index].level}级', style: AppTheme.micro.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: Offset(0.5, 0.5)
                        )
                      ]
                  ))
                ],
              ),
            ),
          ),
          ScreenUtils.verticalSpace(10),
          // 已拥有的卡牌
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
                color: AppTheme.chipColor,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(15))
            ),
            child: Text(S.of(context).playerDetailPocketCards, style: AppTheme.smallDark.copyWith(color: Colors.white)),
          ),
          ScreenUtils.verticalSpace(10),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.playerDetail.cards.length,
            padding: EdgeInsets.symmetric(horizontal: AutoSize.covert.dpToDp(6), vertical: AutoSize.covert.dpToDp(6)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: AutoSize.covert.dpToDp(5),
                mainAxisSpacing: AutoSize.covert.dpToDp(6),
                childAspectRatio: 0.82
            ),
            itemBuilder: (context, index) => Container(
              constraints: BoxConstraints.expand(),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CachedNetworkImage(
                      imageUrl: model.playerDetail.cards[index].iconUrls.medium
                  ),
                  Text('${model.playerDetail.cards[index].level}级', style: AppTheme.micro.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: Offset(0.5, 0.5)
                        )
                      ]
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBattleArea(PlayerViewModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image(image: AssetImage(ImageAssets.ic_left_header), width: 3, height: 12,),
              ScreenUtils.horizontalSpace(6),
              Text(S.of(context).playerDetailUpcomingChests, style: AppTheme.smallDark.copyWith(fontWeight: FontWeight.bold),)
            ],
          ),
          ScreenUtils.verticalSpace(10),
          ScreenUtils.divider(0),
          ScreenUtils.verticalSpace(10),
          _buildChestList(model)
        ],
      ),
    );
  }

  ///TODO: 1.成就墙
  ///TODO: 2.已拥有卡牌在二级弹窗显示（朕已阅）
  ///TODO: 3.GitHub创建项目

}