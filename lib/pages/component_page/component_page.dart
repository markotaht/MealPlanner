import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_planner/component/component_handler.dart';
import 'package:meal_planner/pages/component_page/component_page_content.dart';

import '../../component/component.dart';

class ComponentPage extends StatefulWidget {
  const ComponentPage({super.key, required this.component});

  final Component component;

  @override
  State<StatefulWidget> createState() {
    return _ComponentPageState();
  }
}

class _ComponentPageState extends State<ComponentPage>{
  late ComponentHandler componentHandler;

  @override
  void initState(){
    super.initState();
    componentHandler = ComponentHandler(component: widget.component);
  }

  @override
  void dispose(){
    componentHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: componentHandler, builder: (BuildContext context, Widget? child) {
      return ComponentPageContent(component: componentHandler.component);
    });
  }

}
