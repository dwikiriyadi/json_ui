import 'package:flutter/material.dart';

class EdgeInsetsProperty {
  /// Creates EdgeInsets from a map containing left, top, right, and bottom values
  static EdgeInsetsGeometry? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    
    return EdgeInsets.only(
      left: map["left"]?.toDouble() ?? 0.0,
      top: map["top"]?.toDouble() ?? 0.0,
      right: map["right"]?.toDouble() ?? 0.0,
      bottom: map["bottom"]?.toDouble() ?? 0.0,
    );
  }
  
  /// Gets padding from the property data
  static EdgeInsetsGeometry? getPadding(Map<String, dynamic>? data) {
    final dynamic padding = data?["padding"];
    if (padding == null) return null;
    
    return fromMap(padding);
  }
  
  /// Gets margin from the property data
  static EdgeInsetsGeometry? getMargin(Map<String, dynamic>? data) {
    final dynamic margin = data?["margin"];
    if (margin == null) return null;
    
    return fromMap(margin);
  }
}