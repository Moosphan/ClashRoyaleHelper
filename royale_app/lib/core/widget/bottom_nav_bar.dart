// Copyright 2020 Moosphon. All rights reserved.

import 'package:flutter/material.dart';
import 'package:royale_app/core/resource/style.dart';

/// 自定义首页底部导航栏，可与[TimeoryCenterDockedFab]搭配使用
/// @author Moosphon
class TimeoryBottomNavigationBar extends StatefulWidget{

  TimeoryBottomNavigationBar({
    @required this.items,
    @required this.centerWidth,
    this.height: 50,
    this.backgroundColor: Colors.white,
    this.iconSize: 24,
    this.fontSize: 10,
    this.color: AppTheme.textHintColor,
    this.selectedColor: AppTheme.textPrimaryColor,
    this.onTabSelected
  }) : assert(items.length.isEven); // the items' size should be even numbers.

  final List<TimeoryBottomNavItem> items;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color selectedColor;
  final Color color;
  final double fontSize;
  final ValueChanged<int> onTabSelected;
  final double centerWidth; // center fab size


  @override
  State<StatefulWidget> createState() => _TimeoryBottomNavigationBar();

}

class _TimeoryBottomNavigationBar extends State<TimeoryBottomNavigationBar> {

  int _selectedIndex = 0;

  // change to target bottom item
  _updateItem(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (index) =>
        _buildTabItem(widget.items[index], index, _updateItem)
    );
    items.insert(items.length >> 1, _buildCenterItemHolder());

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items
      ),
    );
  }

  // Build center fab holder
  Widget _buildCenterItemHolder() =>
    SizedBox(
      width: widget.centerWidth,
    );

  // Build each tab item of bottom bar.
  Widget _buildTabItem(TimeoryBottomNavItem item, int index, ValueChanged<int> onPressed) {
    bool isSelected = _selectedIndex == index;
    Color currentColor = isSelected ? widget.selectedColor : widget.color;
    return Expanded(
        child: SizedBox(
          height: widget.height,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(26),
              onTap: () => onPressed(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image(
                          width: 24,
                          height: 24,
                          image: AssetImage(isSelected ? item.selectedIcon : item.unselectedIcon)
                      ),
                      Positioned(
                        right: 0,
                        child: Offstage(
                          offstage: !item.isUnread,
                          child: ClipOval(
                            child: Container(
                              width: 6,
                              height: 6,
                              color: AppTheme.failureColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                  /*Icon(item.iconData, color: currentColor, size: widget.iconSize)*/,
                  SizedBox(height: 4),
                  Text(item.title, style: AppTheme.micro.copyWith(color: currentColor, fontSize: widget.fontSize))
                ],
              ),
            ),
          ),
        )
    );
  }

}

class TimeoryBottomNavItem {
  //final IconData iconData;
  final String selectedIcon;
  final String unselectedIcon;
  final String title;
  final bool isUnread;

  TimeoryBottomNavItem({this.title, this.selectedIcon, this.isUnread: false, this.unselectedIcon});
}