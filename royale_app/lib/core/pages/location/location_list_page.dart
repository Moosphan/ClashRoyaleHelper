// Copyright 2020 Moosphon. All rights reserved.
import 'package:flutter/material.dart';
import 'package:royale_app/core/model/game_locations_model.dart';
import 'package:royale_app/core/provider/extension/partial_consumer_widget.dart';
import 'package:royale_app/core/resource/image_assets.dart';
import 'package:royale_app/core/resource/style.dart';
import 'package:royale_app/core/util/screen_adapt.dart';
import 'package:royale_app/core/viewmodel/location_viewmodel.dart';
import 'package:royale_app/core/widget/common_progress_indicator.dart';
import 'package:royale_app/generated/i18n.dart';

/// 玩家分布地区列表
class LocationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(S.of(context).locationTitle, style: AppTheme.title,),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.6,
        leading: IconButton(
            icon: ImageIcon(AssetImage(ImageAssets.ic_arrow_back), color: AppTheme.primaryColor),
            onPressed: () {
              Navigator.maybePop(context);
            }
        ),
      ),
      body: Container(
        color: Colors.white,
        child: PartialConsumeComponent<LocationViewModel>(
          model: LocationViewModel(),
          initialize: (model) {
            model.getLocations();
          },
          builder: (context, model, _) {
            if (model.isLoading) {
              return _buildLoadingHolder();
            } else if (model.isEmpty) {
              return _buildEmptyHolder();
            } else {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return Divider();
                },
                shrinkWrap: true,
                itemCount: model.locationList.length,
                padding: EdgeInsets.symmetric(horizontal: AutoSize.covert.dpToDp(12), vertical: AutoSize.covert.dpToDp(12)),
                itemBuilder: (context, index) => ListTile(
                  dense: true,
                  onTap: () {
                    Navigator.pop<Location>(context, model.locationList[index]);
                  },
                  trailing: Icon(Icons.arrow_forward_ios, color: AppTheme.textHintColor, size: 12),
                  title: Text(model.locationList[index].name),
                  // todo: add country flag
                ),
              );
            }
          },
        ),
      ),
    );
  }


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

}
