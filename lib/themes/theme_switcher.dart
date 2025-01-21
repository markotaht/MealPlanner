import 'package:flutter/material.dart';
import 'package:meal_planner/themes/themes.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key, required this.home});

  final Widget home;

  @override
  State<StatefulWidget> createState() {
    return _ThemeSwitcherState();
  }
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meal Planner', theme: lightTheme, home: widget.home);
  }
}
