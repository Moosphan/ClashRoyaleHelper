// Copyright 2020 Moosphon. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A common widget from provider for partial update in pages.
/// @author Moosphon
class PartialConsumeComponent<T extends ChangeNotifier> extends StatefulWidget {

  final T model;
  final Widget child;
  final ValueWidgetBuilder<T> builder;
  final Function(T model) initialize;

  PartialConsumeComponent({
    Key key,
    @required this.model,
    @required this.builder,
    this.initialize,
    this.child
  }) : super(key: key);

  @override
  _PartialConsumeComponentState<T> createState() => _PartialConsumeComponentState<T>();

}

class _PartialConsumeComponentState<T extends ChangeNotifier> extends State<PartialConsumeComponent<T>> {

  @override
  void initState() {
    widget.initialize?.call(widget.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: widget.model,
      child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
      ),
    );
  }
}