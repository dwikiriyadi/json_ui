import 'package:flutter/material.dart';
import 'package:json_ui/core/widget/sd_field_item_widget.dart';
import 'package:json_ui/core/property/text_input_type_property.dart';
import 'package:json_ui/core/property/text_input_action_property.dart';
import 'package:json_ui/core/property/text_capitalization_property.dart';
import 'package:json_ui/core/property/font_weight_property.dart';
import 'package:json_ui/core/property/text_align_property.dart';
import 'package:json_ui/core/dispatcher/sd_dispatcher.dart';

class SDTextField extends SDFieldItemWidget<String> {
  SDTextField({super.key, required super.data, super.restorationId})
    : super(
        builder: (context, field) {
          final SDTextFieldState state = field as SDTextFieldState;
          return UnmanagedRestorationScope(
            child: TextField(
              restorationId: restorationId,
              controller: state._effectiveController,
              focusNode: state.focusNode,
              enabled: state.isEnable,
              readOnly: state.isReadOnly,
              decoration: state.decoration,
              keyboardType: state.keyboardType,
              textInputAction: state.textInputAction,
              textCapitalization: state.textCapitalization,
              style: state.textStyle,
              textAlign: state.textAlign,
              obscureText: state.obscureText,
              maxLines: state.maxLines,
              minLines: state.minLines,
              maxLength: state.maxLength,
              onChanged: (value) => state.didChange(value),
            ),
          );
        },
      );

  static void register() {
    SDDispatcher.register(
      componentName: "text_field",
      widget: (data) => SDTextField(data: data),
    );
  }

  @override
  SDFieldItemState<String> createState() => SDTextFieldState();
}

class SDTextFieldState extends SDFieldItemState<String> {
  RestorableTextEditingController? _controller;

  // Cached property values
  InputDecoration? _cachedDecoration;
  TextInputType? _cachedKeyboardType;
  TextInputAction? _cachedTextInputAction;
  TextCapitalization? _cachedTextCapitalization;
  TextStyle? _cachedTextStyle;
  TextAlign? _cachedTextAlign;
  bool? _cachedObscureText;
  int? _cachedMaxLines;
  int? _cachedMinLines;
  int? _cachedMaxLength;

  // Property getters with memoization
  InputDecoration get decoration {
    _cachedDecoration ??= InputDecoration(
        labelText: widget.data["property"]?["label_text"],
        hintText: widget.data["property"]?["hint_text"],
        helperText: widget.data["property"]?["helper_text"],
        prefixText: widget.data["property"]?["prefix_text"],
        suffixText: widget.data["property"]?["suffix_text"],
        border: widget.data["property"]?["border"] == "outline" 
          ? const OutlineInputBorder() 
          : const UnderlineInputBorder(),
      );
    // Always update errorText as it can change
    return _cachedDecoration!.copyWith(errorText: errorMessage);
  }

  TextInputType get keyboardType {
    _cachedKeyboardType ??= TextInputTypeProperty.getTextInputType(
        widget.data["property"]?["keyboard_type"]
      );
    return _cachedKeyboardType!;
  }

  TextInputAction get textInputAction {
    _cachedTextInputAction ??= TextInputActionProperty.getTextInputAction(
        widget.data["property"]?["text_input_action"]
      );
    return _cachedTextInputAction!;
  }

  TextCapitalization get textCapitalization {
    _cachedTextCapitalization ??= TextCapitalizationProperty.getTextCapitalization(
        widget.data["property"]?["text_capitalization"]
      );
    return _cachedTextCapitalization!;
  }

  TextStyle? get textStyle {
    if (_cachedTextStyle == null && widget.data["property"]?["style"] != null) {
      _cachedTextStyle = TextStyle(
        fontSize: widget.data["property"]?["style"]?["font_size"],
        fontWeight: FontWeightProperty.getFontWeight(
          widget.data["property"]?["style"]?["font_weight"]
        ),
        color: widget.data["property"]?["style"]?["color"] != null 
          ? Color(int.parse(widget.data["property"]?["style"]?["color"], radix: 16)) 
          : null,
      );
    }
    return _cachedTextStyle;
  }

  TextAlign get textAlign {
    _cachedTextAlign ??= TextAlignProperty.getTextAlign(
        widget.data["property"]?["text_align"]
      );
    return _cachedTextAlign!;
  }

  bool get obscureText {
    _cachedObscureText ??= widget.data["property"]?["obscure_text"] ?? false;
    return _cachedObscureText!;
  }

  int? get maxLines {
    _cachedMaxLines ??= widget.data["property"]?["max_lines"];
    return _cachedMaxLines;
  }

  int? get minLines {
    _cachedMinLines ??= widget.data["property"]?["min_lines"];
    return _cachedMinLines;
  }

  int? get maxLength {
    _cachedMaxLength ??= widget.data["property"]?["max_length"];
    return _cachedMaxLength;
  }

  TextEditingController get _effectiveController => _controller!.value;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    // Make sure to update the internal [FormFieldState] value to sync up with
    // text editing controller value.
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller =
        value == null
            ? RestorableTextEditingController()
            : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    _createLocalController(
      value != null ? TextEditingValue(text: value!) : null,
    );
  }

  @override
  void dispose() {
    // Clear all cached properties to prevent memory leaks
    _cachedDecoration = null;
    _cachedKeyboardType = null;
    _cachedTextInputAction = null;
    _cachedTextCapitalization = null;
    _cachedTextStyle = null;
    _cachedTextAlign = null;
    _cachedObscureText = null;
    _cachedMaxLines = null;
    _cachedMinLines = null;
    _cachedMaxLength = null;

    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.value = TextEditingValue(text: value ?? '');
    }
  }

  @override
  void reset() {
    // Set the controller value before calling super.reset() to let
    // _handleControllerChanged suppress the change.
    _effectiveController.value = TextEditingValue(text: value ?? '');
    super.reset();
  }
}
