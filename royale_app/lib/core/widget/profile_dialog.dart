// Copyright 2020 Moosphon. All rights reserved.
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:royale_app/core/pages/player/player_detail_page.dart';
import 'package:royale_app/core/resource/image_assets.dart';
import 'package:royale_app/core/resource/style.dart';
import 'package:royale_app/core/util/screen_utils.dart';
/// The dialog of player profile binding info.
class PlayerProfileDialog extends Dialog {

  PlayerProfileDialog({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // 透明区域点击关闭弹窗
          GestureDetector(
            onTap: () {
              Navigator.maybePop(context);
            },
          ),
          // 弹窗UI
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 5 * 4,
              height: 280,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Row(
                        children: <Widget>[
                          Image(image: AssetImage(ImageAssets.ic_player_profile), width: 32, height: 32),
                          ScreenUtils.horizontalSpace(12),
                          Text('Welcome!', style: AppTheme.body1.copyWith(fontWeight: FontWeight.w600))
                        ],
                      ),
                    ),
                    ScreenUtils.divider(0),
                    Container(
                      margin: EdgeInsets.only(top: 12, left: 18, right: 18, bottom: 12),
                      child: Text(
                        'Sign in to save player\'s game data, reserves seats and rate sessions(if an attendee).Actions will be synced from your account across app and site.',
                        style: AppTheme.body2,
                        strutStyle: StrutStyle(forceStrutHeight: true, height: 1.2, leading: 0.8),
                        softWrap: true,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        var tag = '#PV2UJ0VYR';
                        Fluttertoast.showToast(msg: '绑定玩家$tag');
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => PlayerDetailPage(tag: tag))
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        child: Row(
                          children: <Widget>[
                            Image(image: AssetImage(ImageAssets.ic_player_login), width: 24, height: 24),
                            ScreenUtils.horizontalSpace(20),
                            Text('Sign in', style: AppTheme.body1.copyWith(fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                    ),
                    ScreenUtils.divider(0),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Privacy policy • About us', style: AppTheme.body2.copyWith(color: AppTheme.textHintColor),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}