// Copyright 2020 Moosphon. All rights reserved.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:royale_app/core/model/base/common_model.dart';
import 'package:royale_app/core/provider/extension/partial_consumer_widget.dart';
import 'package:royale_app/core/resource/image_assets.dart';
import 'package:royale_app/core/resource/style.dart';
import 'package:royale_app/core/util/screen_adapt.dart';
import 'package:royale_app/core/viewmodel/card_viewmodel.dart';
import 'package:royale_app/core/widget/common_progress_indicator.dart';

/// Game available Cards page.
class CardListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('卡组', style: AppTheme.title,),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.6,
      ),
      body: Container(
        color: AppTheme.surfaceColor,
        child: PartialConsumeComponent<CardViewModel>(
          model: CardViewModel(),
          initialize: (model) {
            model.getCards();
          },
          builder: (context, model, _) {
            if (model.isLoading) {
              return _buildLoadingHolder();
            } else if (model.isEmpty) {
              return _buildEmptyHolder();
            } else {
              return GridView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: model.cardList.length,
                padding: EdgeInsets.symmetric(horizontal: AutoSize.covert.dpToDp(12), vertical: AutoSize.covert.dpToDp(12)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: AutoSize.covert.dpToDp(12),
                    mainAxisSpacing: AutoSize.covert.dpToDp(12),
                    childAspectRatio: 0.82
                ),
                itemBuilder: (context, index) => _buildCardItem(model.cardList, index),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildEmptyHolder() =>
      Center(
        child: Image(
          width: AutoSize.covert.dpToDp(126),
          height: AutoSize.covert.dpToDp(105),
          image: AssetImage(ImageAssets.ic_empty_search),
        ),
      );

  Widget _buildLoadingHolder() =>
      Center(
        child: CommonProgressIndicator(
          color: AppTheme.primaryColor,
        ),
      );

  Widget _buildCardItem(List<RoleCard> cards, index) =>
      Container(
        child: GestureDetector(
          onTap: () {

          },
          child: Container(
            constraints: BoxConstraints.expand(),
            child: CachedNetworkImage(imageUrl: cards[index].iconUrls.medium),
          ),
        ),
      );
}
