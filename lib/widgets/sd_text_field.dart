import 'package:flutter/material.dart';
import 'package:json_ui/core/widget/sd_field_item_widget.dart';

// TODO map data property into the widget

class SDTextField extends SDFieldItemWidget<String> {
  SDTextField({super.key, required super.data, super.restorationId})
    : super(
        builder: (field) {
          final _SDTextFieldState state = field as _SDTextFieldState;
          return UnmanagedRestorationScope(
            child: TextField(
              restorationId: restorationId,
              controller: state._effectiveController,
              focusNode: state.focusNode,
            ),
          );
        },
      );

  @override
  SDFieldItemState<String> createState() => _SDTextFieldState();
}

class _SDTextFieldState extends SDFieldItemState<String> {
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
