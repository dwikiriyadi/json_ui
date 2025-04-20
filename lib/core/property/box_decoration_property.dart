import 'package:flutter/material.dart' hide ColorProperty;
import 'package:json_ui/core/property/color_property.dart';

class BoxDecorationProperty {
  /// Creates a BoxDecoration from decoration data
  static BoxDecoration? fromMap(Map<String, dynamic>? decoration) {
    if (decoration == null) return null;
    
    // Parse background color
    Color? backgroundColor = ColorProperty.getColor(decoration, "background_color");
    
    // Parse border radius
    BorderRadius? borderRadius;
    if (decoration["border_radius"] != null) {
      borderRadius = BorderRadius.circular(
        decoration["border_radius"]?.toDouble() ?? 0.0,
      );
    }
    
    // Parse border
    Border? border;
    if (decoration["border"] != null) {
      final dynamic borderData = decoration["border"];
      border = Border.all(
        color: ColorProperty.getColor(borderData, "color") ?? Colors.transparent,
        width: borderData["width"]?.toDouble() ?? 1.0,
      );
    }
    
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
      border: border,
    );
  }
  
  /// Gets decoration from the property data
  static BoxDecoration? getDecoration(Map<String, dynamic>? data) {
    final dynamic decoration = data?["decoration"];
    if (decoration == null) return null;
    
    return fromMap(decoration);
  }
}