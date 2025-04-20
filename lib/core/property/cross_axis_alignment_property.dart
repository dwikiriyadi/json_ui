import 'package:flutter/material.dart';

class CrossAxisAlignmentProperty {
  static final Map<String, CrossAxisAlignment> _crossAxisAlignmentMap = {
    "start": CrossAxisAlignment.start,
    "end": CrossAxisAlignment.end,
    "center": CrossAxisAlignment.center,
    "stretch": CrossAxisAlignment.stretch,
    "baseline": CrossAxisAlignment.baseline,
  };

  static CrossAxisAlignment getCrossAxisAlignment(String? alignment) {
    if (alignment == null) return CrossAxisAlignment.center;
    return _crossAxisAlignmentMap[alignment] ?? CrossAxisAlignment.center;
  }
}