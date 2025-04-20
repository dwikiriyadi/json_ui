import 'package:flutter/material.dart';

class ColorProperty {
  /// Parses a color from a hexadecimal string
  static Color? fromHex(String? hexString) {
    if (hexString == null) return null;
    
    try {
      return Color(int.parse(hexString, radix: 16));
    } catch (e) {
      return null;
    }
  }
  
  /// Gets a color from the property data
  static Color? getColor(Map<String, dynamic>? data, String key) {
    final String? colorHex = data?[key];
    return fromHex(colorHex);
  }
}