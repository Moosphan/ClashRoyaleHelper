// Copyright 2020 Moosphon. All rights reserved.

import 'package:flutter/material.dart';
import 'package:royale_app/core/pages/home/home_page.dart';
import 'package:royale_app/core/resource/image_assets.dart';
import 'package:royale_app/core/service/hidden_repository.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    // avoid: dependOnInheritedWidgetOfExactType<_LocalizationsScope>() or dependOnInheritedElement() was called before _SplashPageState.initState() completed.
    Future.delayed(Duration.zero, () {
      _init();
    });
  }

  void _init() {
    HiddenDataRepository.init(context, () {
      Future.delayed(Duration(seconds: 3)).then((data) {
        Navigator.of(context).pushReplacementNamed('/homePage');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.bg_splash),
            fit: BoxFit.cover
          )
        ),
        child: _buildSplashComponent(),
      ),
    );
  }

  Widget _buildSplashComponent() =>
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: Colors.black.withOpacity(0.48),
            constraints: BoxConstraints.expand(),
          ),
//          Positioned(
//              bottom: 0,
//              right: 0,
//              child: Image(
//                  width: AutoSize.covert.dpToDp(181),
//                  height: AutoSize.covert.dpToDp(83),
//                  fit: BoxFit.contain,
//                  image: AssetImage(ImageAssets.holder_splash_footer)
//              )
//          )

        ],
      );

}
