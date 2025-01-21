import 'package:flutter/material.dart';

class TabFloatingActionButton extends StatefulWidget {
  const TabFloatingActionButton(
      {super.key, this.tabController, required this.children});

  final TabController? tabController;
  final List<Widget?> children;

  @override
  State<StatefulWidget> createState() {
    return _TabFloatingActionButtonState();
  }
}

class _TabFloatingActionButtonState extends State<TabFloatingActionButton> {
  TabController? _controller;
  int? _currentIndex;

  void _updateTabController() {
    final TabController? newController =
        widget.tabController ?? DefaultTabController.maybeOf(context);
    _controller = newController;
    if (_controller != null) {
      _controller!.animation!.addListener(_handleTabControllerAnimationTick);
    }
  }

  void _handleTabControllerAnimationTick() {
    if (_controller!.index != _currentIndex) {
      setState(() {
        _currentIndex = _controller!.index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateTabController();
    _currentIndex = _controller!.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
    _currentIndex = _controller!.index;
  }

  @override
  void didUpdateWidget(TabFloatingActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabController != oldWidget.tabController) {
      _updateTabController();
      _currentIndex = _controller!.index;
    }
  }

  @override
  void dispose() {
    _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("here");
    debugPrint(_currentIndex.toString());
    return widget.children[_currentIndex as int] ?? Container();
  }
}
