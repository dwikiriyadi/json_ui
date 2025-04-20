import 'package:flutter/material.dart';

class TextInputActionProperty {
  static final Map<String, TextInputAction> _textInputActionMap = {
    "none": TextInputAction.none,
    "unspecified": TextInputAction.unspecified,
    "done": TextInputAction.done,
    "go": TextInputAction.go,
    "search": TextInputAction.search,
    "send": TextInputAction.send,
    "next": TextInputAction.next,
    "previous": TextInputAction.previous,
    "continueAction": TextInputAction.continueAction,
    "join": TextInputAction.join,
    "route": TextInputAction.route,
    "emergencyCall": TextInputAction.emergencyCall,
    "newline": TextInputAction.newline,
  };

  static TextInputAction? getTextInputAction(String? action) {
    if (action == null) return null;
    return _textInputActionMap[action] ?? TextInputAction.done;
  }
}