// Copyright 2019 Ucardstore LLC. All rights reserved.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:royale_app/core/resource/style.dart';

/// 自定义的圆形头像组件
/// @author Moosphon
class RoundedAvatar extends StatefulWidget {

 const RoundedAvatar({Key key,
    @required this.imageResource,
    this.isRemote = false,
    this.borderColor = AppTheme.avatarBorderColor,
    this.borderWidth = 1,
    @required this.width,
    @required this.height})
      : assert(imageResource != null),
        super(key: key);

  final String imageResource;
  final double width;
  final double height;
  final bool isRemote;
  final Color borderColor;
  final double borderWidth;

  @override
  State<StatefulWidget> createState() {
    return _CircleAvatarState();
  }

}

class _CircleAvatarState extends State<RoundedAvatar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(
        side: BorderSide(
          color: widget.borderColor,
          width: widget.borderWidth
        )
      ),
      clipBehavior: Clip.hardEdge,
      child: widget.isRemote
          ? CachedNetworkImage(
        imageUrl: widget.imageResource,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
      ) : Image.asset(
        widget.imageResource,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
      ),
    );
  }

}