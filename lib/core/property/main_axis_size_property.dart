import 'package:flutter/material.dart';

class MainAxisSizeProperty {
  static final Map<String, MainAxisSize> _mainAxisSizeMap = {
    "min": MainAxisSize.min,
    "max": MainAxisSize.max,
  };

  static MainAxisSize getMainAxisSize(String? size) {
    if (size == null) return MainAxisSize.max;
    return _mainAxisSizeMap[size] ?? MainAxisSize.max;
  }
}