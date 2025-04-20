import 'package:flutter/material.dart';

class FontWeightProperty {
  static final Map<String, FontWeight> _fontWeightMap = {
    "bold": FontWeight.bold,
    "normal": FontWeight.normal,
    "w100": FontWeight.w100,
    "w200": FontWeight.w200,
    "w300": FontWeight.w300,
    "w400": FontWeight.w400,
    "w500": FontWeight.w500,
    "w600": FontWeight.w600,
    "w700": FontWeight.w700,
    "w800": FontWeight.w800,
    "w900": FontWeight.w900,
  };

  static FontWeight? getFontWeight(String? weight) {
    if (weight == null) return null;
    return _fontWeightMap[weight] ?? FontWeight.normal;
  }
}