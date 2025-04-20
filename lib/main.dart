import 'package:flutter/material.dart';
import 'package:json_ui/app.dart';
import 'package:json_ui/core/registry/validator_registry.dart';

void main() {
  // Register validators
  ValidatorRegistry.register();

  runApp(const App());
}
