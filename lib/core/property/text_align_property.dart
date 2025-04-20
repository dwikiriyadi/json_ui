import 'package:flutter/material.dart';

class TextAlignProperty {
  static final Map<String, TextAlign> _textAlignMap = {
    "left": TextAlign.left,
    "right": TextAlign.right,
    "center": TextAlign.center,
    "justify": TextAlign.justify,
    "start": TextAlign.start,
    "end": TextAlign.end,
  };

  static TextAlign getTextAlign(String? align) {
    if (align == null) return TextAlign.start;
    return _textAlignMap[align] ?? TextAlign.start;
  }
}