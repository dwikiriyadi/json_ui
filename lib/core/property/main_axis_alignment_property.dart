import 'package:flutter/material.dart';

class MainAxisAlignmentProperty {
  static final Map<String, MainAxisAlignment> _mainAxisAlignmentMap = {
    "start": MainAxisAlignment.start,
    "end": MainAxisAlignment.end,
    "center": MainAxisAlignment.center,
    "spaceBetween": MainAxisAlignment.spaceBetween,
    "spaceAround": MainAxisAlignment.spaceAround,
    "spaceEvenly": MainAxisAlignment.spaceEvenly,
  };

  static MainAxisAlignment getMainAxisAlignment(String? alignment) {
    if (alignment == null) return MainAxisAlignment.start;
    return _mainAxisAlignmentMap[alignment] ?? MainAxisAlignment.start;
  }
}