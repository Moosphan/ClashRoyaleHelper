// Copyright 2019 Ucardstore LLC. All rights reserved.
import 'package:flutter/material.dart';
import 'package:royale_app/core/resource/style.dart';

/// 简单自定义凸起效果的Fab，与[TimeoryBottomNavigationBar]搭配使用
/// @author Moosphon
class TimeoryCenterDockedFab extends StatelessWidget {

  final String icon;
  final Color color;
  final VoidCallback onFabPressed;

  TimeoryCenterDockedFab({
    this.icon,
    this.color,
    @required this.onFabPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 42),
      padding: EdgeInsets.all(7),
      width: 66,
      height: 66,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black26.withAlpha(60),
                offset: Offset(0, -4),
                blurRadius: 4,
                spreadRadius: -6
            )
          ]
      ),
      child: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        onPressed: onFabPressed,
        //child: Icon(Icons.edit, color: Colors.white),

        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [BoxShadow(
                color: color,
                offset: Offset(0, 2),
                blurRadius: 8,
              )]
          ),
          child: Center(
            child: Image(
              image: AssetImage(icon),
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }

}