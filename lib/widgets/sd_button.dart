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
              state.widget.data["property"]?["text"] ?? "",
              style: TextStyle(
                fontSize:
                    state.widget.data["property"]?["font_size"]?.toDouble(),
                fontWeight: FontWeightProperty.getFontWeight(
                  state.widget.data["property"]?["font_weight"],
                ),
                color: custom.ColorProperty.getColor(
                  state.widget.data["property"],
                  "text_color",
                ),
              ),
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
  // No need to override build as it's already implemented in SDContainerItemState
}
