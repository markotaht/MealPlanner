import 'package:flutter/material.dart';

@immutable
class AlternatingListTileTheme
    extends ThemeExtension<AlternatingListTileTheme> {
  final Color? evenColor;
  final Color? oddColor;
  final ShapeBorder? shape;

  const AlternatingListTileTheme({this.evenColor, this.oddColor, this.shape});

  @override
  ThemeExtension<AlternatingListTileTheme> copyWith(
      {Color? evenColor, Color? oddColor, ShapeBorder? shape}) {
    return AlternatingListTileTheme(
        evenColor: evenColor ?? this.evenColor,
        oddColor: oddColor ?? this.oddColor,
        shape:  shape ?? this.shape);
  }

  @override
  ThemeExtension<AlternatingListTileTheme> lerp(
      covariant ThemeExtension<AlternatingListTileTheme>? other, double t) {
    if (other is! AlternatingListTileTheme) {
      return this;
    }

    return AlternatingListTileTheme(
        evenColor: Color.lerp(evenColor, other.evenColor, t) ?? Colors.white,
        oddColor: Color.lerp(oddColor, other.oddColor, t) ?? Colors.grey,
        shape: ShapeBorder.lerp(shape, other.shape, t));
  }
}
