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
          final textState = state as SDTextState;
          return Text(
            textState.text,
            style: textState.textStyle,
            textAlign: textState.textAlign,
            overflow: textState.overflow,
            maxLines: textState.maxLines,
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
  // Cached property values
  String? _cachedText;
  TextStyle? _cachedTextStyle;
  TextAlign? _cachedTextAlign;
  TextOverflow? _cachedOverflow;
  int? _cachedMaxLines;

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
        color: CustomColorProperty.ColorProperty.getColor(
          widget.data["property"],
          "color",
        ),
      );
    return _cachedTextStyle!;
  }

  TextAlign get textAlign {
    _cachedTextAlign ??= TextAlignProperty.getTextAlign(
        widget.data["property"]?["text_align"],
      );
    return _cachedTextAlign!;
  }

  TextOverflow? get overflow {
    if (_cachedOverflow == null) {
      final overflowValue = widget.data["property"]?["overflow"];
      if (overflowValue == "ellipsis") {
        _cachedOverflow = TextOverflow.ellipsis;
      } else if (overflowValue == "fade") {
        _cachedOverflow = TextOverflow.fade;
      } else if (overflowValue == "visible") {
        _cachedOverflow = TextOverflow.visible;
      } else if (overflowValue == "clip") {
        _cachedOverflow = TextOverflow.clip;
      }
    }
    return _cachedOverflow;
  }

  int? get maxLines {
    _cachedMaxLines ??= widget.data["property"]?["max_lines"];
    return _cachedMaxLines;
  }

  @override
  void dispose() {
    // Clear all cached properties to prevent memory leaks
    _cachedText = null;
    _cachedTextStyle = null;
    _cachedTextAlign = null;
    _cachedOverflow = null;
    _cachedMaxLines = null;

    super.dispose();
  }
}
