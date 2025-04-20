import 'package:flutter/material.dart';

class TextCapitalizationProperty {
  static final Map<String, TextCapitalization> _textCapitalizationMap = {
    "words": TextCapitalization.words,
    "sentences": TextCapitalization.sentences,
    "characters": TextCapitalization.characters,
  };

  static TextCapitalization getTextCapitalization(String? capitalization) {
    if (capitalization == null) return TextCapitalization.none;
    return _textCapitalizationMap[capitalization] ?? TextCapitalization.none;
  }
}