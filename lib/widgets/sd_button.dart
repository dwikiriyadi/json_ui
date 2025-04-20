import 'package:flutter/material.dart';
import 'package:json_ui/core/dispatcher/sd_dispatcher.dart';
import 'package:json_ui/core/mixin/sd_pressed.dart';
import 'package:json_ui/core/property/color_property.dart' as custom;
import 'package:json_ui/core/property/font_weight_property.dart';
import 'package:json_ui/core/widget/sd_container_item_widget.dart';

class SDButton extends SDContainerItemWidget {
  SDButton({super.key, required super.data, super.restorationId})
    : super(
        builder: (context, state) {
          final buttonState = state as SDButtonState;

          return ElevatedButton(
            onPressed: buttonState.triggerOnPressed,
            style: Theme.of(context).elevatedButtonTheme.style,
            child: Text(
              buttonState.text,
              style: buttonState.textStyle,
            ),
          );
        },
      );

  static void register() {
    SDDispatcher.register(
      componentName: "button",
      widget: (data) => SDButton(data: data),
    );
  }

  @override
  State<StatefulWidget> createState() => SDButtonState();
}

class SDButtonState extends SDContainerItemState<SDButton> with SDPressed {
  // Cached property values
  String? _cachedText;
  TextStyle? _cachedTextStyle;

  // Property getters with memoization
  String get text {
    return _cachedText ??= widget.data["property"]?["text"] ?? "";
  }

  TextStyle get textStyle {
    _cachedTextStyle ??= TextStyle(
        fontSize: widget.data["property"]?["font_size"]?.toDouble(),
        fontWeight: FontWeightProperty.getFontWeight(
          widget.data["property"]?["font_weight"],
        ),
        color: custom.ColorProperty.getColor(
          widget.data["property"],
          "text_color",
        ),
      );
    return _cachedTextStyle!;
  }

  @override
  void dispose() {
    // Clear all cached properties to prevent memory leaks
    _cachedText = null;
    _cachedTextStyle = null;

    super.dispose();
  }
}
