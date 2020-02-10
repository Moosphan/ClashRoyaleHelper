// Copyright 2020 Moosphon. All rights reserved.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:royale_app/core/model/player_battle_log_model.dart';
import 'package:royale_app/core/resource/image_assets.dart';
import 'package:royale_app/core/resource/style.dart';
import 'package:royale_app/core/util/screen_adapt.dart';
import 'package:royale_app/core/util/screen_utils.dart';
/// Player recently battles info.
class PlayerBattlesPage extends StatelessWidget {

  final List<PlayerBattleLog> battleLogs;
  final String player;

  PlayerBattlesPage(this.player, this.battleLogs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$player的战斗记录', style: AppTheme.title,),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.6,
        leading: IconButton(
            icon: ImageIcon(AssetImage(ImageAssets.ic_arrow_back), color: AppTheme.primaryColor, size: 24,),
            onPressed: () {
              Navigator.maybePop(context);
            }
        )
      ),

      body: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return Divider();
          },
          shrinkWrap: true,
          itemCount: battleLogs.length,
          padding: EdgeInsets.symmetric(horizontal: AutoSize.covert.dpToDp(10)),
          itemBuilder: (context, index) => _buildBattleItem(battleLogs[index]),
        ),
      ),
    );
  }

  Widget _buildBattleItem(PlayerBattleLog battle) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Container(
                    margin: EdgeInsets.only(right: 60),
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    decoration: BoxDecoration(
                        color: battle.won ? AppTheme.chipColor : AppTheme.failureColor,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(15))
                    ),
                    child: Text(battle.won ? '胜利' : '失败', style: AppTheme.smallDark.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              Expanded(child: Text('${battle.team.first.crowns} - ${battle.opponent.first.crowns}', style: AppTheme.body1.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
              Expanded(child: Text('天梯对战', style: AppTheme.small, textAlign: TextAlign.right,))
            ],
          ),
          ScreenUtils.verticalSpace(12),
          // 1v1 view
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Text(
                        battle.team.first.name,
                        style: AppTheme.small.copyWith(color: AppTheme.textSecondaryColor, fontWeight: FontWeight.w600),
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('vs', style: AppTheme.body2.copyWith(color: AppTheme.textHintColor), textAlign: TextAlign.center)
                  ),
                  Expanded(
                      child: Text(
                        battle.opponent.first.name,
                        style: AppTheme.small.copyWith(color: AppTheme.textSecondaryColor, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.right,
                      )
                  )
                ],
              ),
              ScreenUtils.verticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image(image: AssetImage(ImageAssets.ic_cr_cups), width: 12, height: 12),
                              ScreenUtils.horizontalSpace(4),
                              Text(battle.team.first.startingTrophies.toString(), style: AppTheme.smallDark),
                              Offstage(
                                offstage: battle.team.first.trophyChange == null,
                                child: Text(
                                    '${(battle.team.first.trophyChange != null && battle.team.first.trophyChange > 0) ? '+' : ''}${battle.team.first.trophyChange ?? ''}',
                                    style: AppTheme.small
                                ),
                              )
                            ],
                          ),
                          ScreenUtils.verticalSpace(10),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: battle.team.first.cards.length,
                            padding: EdgeInsets.symmetric(vertical: AutoSize.covert.dpToDp(6)),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
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
                                      imageUrl: battle.team.first.cards[index].iconUrls.medium
                                  ),
                                  Text('${battle.team.first.cards[index].level}级', style: AppTheme.micro.copyWith(
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
                    ),
                  ),

                  Container(
                    color: AppTheme.borderColor,
                    width: 0.8,
                    height: 112,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),

                  // 1p enemy info
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(battle.opponent.first.startingTrophies.toString(), style: AppTheme.smallDark),
                              Offstage(
                                offstage: battle.opponent.first.trophyChange == null,
                                child: Text(
                                    '${(battle.opponent.first.trophyChange != null && battle.opponent.first.trophyChange > 0) ? '+' : ''}${battle.opponent.first.trophyChange ?? ''}',
                                    style: AppTheme.small
                                ),
                              ),
                              ScreenUtils.horizontalSpace(4),
                              Image(image: AssetImage(ImageAssets.ic_cr_cups), width: 12, height: 12),
                            ],
                          ),

                          ScreenUtils.verticalSpace(10),

                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: battle.opponent.first.cards.length,
                            padding: EdgeInsets.symmetric(vertical: AutoSize.covert.dpToDp(6)),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: AutoSize.covert.dpToDp(4),
                                mainAxisSpacing: AutoSize.covert.dpToDp(4),
                                childAspectRatio: 0.82
                            ),
                            itemBuilder: (context, index) => Container(
                              constraints: BoxConstraints.expand(),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  CachedNetworkImage(
                                      imageUrl: battle.opponent.first.cards[index].iconUrls.medium
                                  ),
                                  Text('${battle.opponent.first.cards[index].level}级', style: AppTheme.micro.copyWith(
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
                    ),
                  ),
                ],
              ),
            ],
          ),
          ScreenUtils.verticalSpace(10),
          // 2v2, the other member
          battle.team.length == 1 ? ScreenUtils.verticalSpace(2) : _build2pBattleComponent(battle),
          ScreenUtils.verticalSpace(10),
          Text(DateTime.tryParse(battle.battleTime).toString().substring(0, 16), style: AppTheme.small),
        ],
      ),
    );
  }

  Widget _build2pBattleComponent(PlayerBattleLog battle) => Offstage(
    offstage: battle.team.length == 1,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Text(
                  battle.team[1].name,
                  style: AppTheme.small.copyWith(color: AppTheme.textSecondaryColor, fontWeight: FontWeight.w600),
                )
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('2P', style: AppTheme.body2.copyWith(color: AppTheme.textHintColor), textAlign: TextAlign.center)
            ),
            Expanded(
                child: Text(
                  battle.opponent[1].name,
                  style: AppTheme.small.copyWith(color: AppTheme.textSecondaryColor, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.right,
                )
            )
          ],
        ),
        ScreenUtils.verticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                //width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  children: <Widget>[
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: battle.team[1].cards.length,
                      padding: EdgeInsets.symmetric(vertical: AutoSize.covert.dpToDp(6)),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
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
                                imageUrl: battle.team[1].cards[index].iconUrls.medium
                            ),
                            Text('${battle.team[1].cards[index].level}级', style: AppTheme.micro.copyWith(
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
              ),
            ),

            Container(
              color: AppTheme.borderColor,
              width: 0.8,
              height: 112,
              margin: EdgeInsets.symmetric(horizontal: 10),
            ),

            Expanded(
              child: Container(
                //width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  children: <Widget>[

                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: battle.opponent[1].cards.length,
                      padding: EdgeInsets.symmetric(vertical: AutoSize.covert.dpToDp(6)),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: AutoSize.covert.dpToDp(4),
                          mainAxisSpacing: AutoSize.covert.dpToDp(4),
                          childAspectRatio: 0.82
                      ),
                      itemBuilder: (context, index) => Container(
                        constraints: BoxConstraints.expand(),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            CachedNetworkImage(
                                imageUrl: battle.opponent[1].cards[index].iconUrls.medium
                            ),
                            Text('${battle.opponent[1].cards[index].level}级', style: AppTheme.micro.copyWith(
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
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
