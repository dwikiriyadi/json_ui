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
              decoration: InputDecoration(
                labelText: state.widget.data["property"]?["label_text"],
                hintText: state.widget.data["property"]?["hint_text"],
                helperText: state.widget.data["property"]?["helper_text"],
                errorText: state.errorMessage,
                prefixText: state.widget.data["property"]?["prefix_text"],
                suffixText: state.widget.data["property"]?["suffix_text"],
                border: state.widget.data["property"]?["border"] == "outline" 
                  ? const OutlineInputBorder() 
                  : const UnderlineInputBorder(),
              ),
              keyboardType: TextInputTypeProperty.getTextInputType(state.widget.data["property"]?["keyboard_type"]),
              textInputAction: TextInputActionProperty.getTextInputAction(state.widget.data["property"]?["text_input_action"]),
              textCapitalization: TextCapitalizationProperty.getTextCapitalization(state.widget.data["property"]?["text_capitalization"]),
              style: state.widget.data["property"]?["style"] != null 
                ? TextStyle(
                    fontSize: state.widget.data["property"]?["style"]?["font_size"],
                    fontWeight: FontWeightProperty.getFontWeight(state.widget.data["property"]?["style"]?["font_weight"]),
                    color: state.widget.data["property"]?["style"]?["color"] != null 
                      ? Color(int.parse(state.widget.data["property"]?["style"]?["color"], radix: 16)) 
                      : null,
                  ) 
                : null,
              textAlign: TextAlignProperty.getTextAlign(state.widget.data["property"]?["text_align"]),
              obscureText: state.widget.data["property"]?["obscure_text"] ?? false,
              maxLines: state.widget.data["property"]?["max_lines"],
              minLines: state.widget.data["property"]?["min_lines"],
              maxLength: state.widget.data["property"]?["max_length"],
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
