import 'package:flutter/material.dart';
import 'package:meal_planner/initializer.dart';
import 'package:meal_planner/pages/home_page.dart';
import 'package:meal_planner/themes/theme_switcher.dart';


void main() async{
  Initializer.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const ThemeSwitcher(
      home: HomePage(title: 'Meal Planner'),
    );
  }
}