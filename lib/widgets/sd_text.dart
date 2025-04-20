import 'package:flutter/widgets.dart';
import 'package:json_ui/core/dispatcher/sd_dispatcher.dart';
import 'package:json_ui/core/property/text_align_property.dart';
import 'package:json_ui/core/property/font_weight_property.dart';
import 'package:json_ui/core/property/color_property.dart' as CustomColorProperty;
import 'package:json_ui/core/widget/sd_item_widget.dart';

class SDText extends SDItemWidget {
  SDText({super.key, required super.data, super.restorationId})
    : super(
        builder: (context, state) {
          return Text(
            state.widget.data["property"]?["text"] ?? "",
            style: TextStyle(
              fontSize: state.widget.data["property"]?["font_size"]?.toDouble(),
              fontWeight: FontWeightProperty.getFontWeight(
                state.widget.data["property"]?["font_weight"],
              ),
              color: CustomColorProperty.ColorProperty.getColor(
                state.widget.data["property"],
                "color",
              ),
            ),
            textAlign: TextAlignProperty.getTextAlign(
              state.widget.data["property"]?["text_align"],
            ),
            overflow:
                state.widget.data["property"]?["overflow"] == "ellipsis"
                    ? TextOverflow.ellipsis
                    : state.widget.data["property"]?["overflow"] == "fade"
                    ? TextOverflow.fade
                    : state.widget.data["property"]?["overflow"] == "visible"
                    ? TextOverflow.visible
                    : state.widget.data["property"]?["overflow"] == "clip"
                    ? TextOverflow.clip
                    : null,
            maxLines: state.widget.data["property"]?["max_lines"],
          );
        },
      );

  static void register() {
    SDDispatcher.register(
      componentName: "text",
      widget: (data) => SDText(data: data),
    );
  }

  @override
  State<StatefulWidget> createState() => SDTextState();
}

class SDTextState extends SDItemState<SDText> {
  // No need to override build as it's already implemented in SDItemState
}
