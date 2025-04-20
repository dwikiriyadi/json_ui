import 'package:flutter/material.dart';

class TextInputTypeProperty {
  static final Map<String, TextInputType> _textInputTypeMap = {
    "text": TextInputType.text,
    "multiline": TextInputType.multiline,
    "number": TextInputType.number,
    "phone": TextInputType.phone,
    "datetime": TextInputType.datetime,
    "emailAddress": TextInputType.emailAddress,
    "url": TextInputType.url,
    "visiblePassword": TextInputType.visiblePassword,
  };

  static TextInputType? getTextInputType(String? type) {
    if (type == null) return null;
    return _textInputTypeMap[type] ?? TextInputType.text;
  }
}