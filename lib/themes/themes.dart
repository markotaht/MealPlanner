import 'package:flutter/material.dart';
import 'package:meal_planner/themes/extensions/alternating_list_tile_theme.dart';

const AlternatingListTileTheme lightAlternatingListTileTheme =
    AlternatingListTileTheme(
        evenColor: Color(0x00000000),
        oddColor: Color(0xdddddddd),
        shape: Border(bottom: BorderSide(width: 2, color: Color(0xaaaaaaaa))));

final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
            backgroundColor: MaterialStatePropertyAll(Colors.grey),
            shape: MaterialStatePropertyAll(ContinuousRectangleBorder()))),
    extensions: const [lightAlternatingListTileTheme]);
