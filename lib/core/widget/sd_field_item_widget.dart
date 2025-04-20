import 'package:flutter/widgets.dart';
import 'package:json_ui/core/dispatcher/validator_dispatcher.dart';
import 'package:json_ui/core/sd_generator.dart';
import 'package:json_ui/core/validation/validator.dart';
import 'package:json_ui/core/widget/sd_item_widget.dart';

part "sd_field_item_state.dart";

abstract class SDFieldItemWidget<T> extends SDItemWidget {
  /// An optional method to call with the final value when the form is saved via
  /// [SDGenerator.save].
  final FormFieldSetter<T>? onSaved;

  /// An optional property that forces the [FormFieldState] into an error state
  /// by directly setting the [FormFieldState.errorText] property without
  /// running the validator function.
  ///
  /// When the [forceErrorText] property is provided, the [FormFieldState.errorText]
  /// will be set to the provided value, causing the form field to be considered
  /// invalid and to display the error message specified.
  ///
  /// When [validator] is provided, [forceErrorText] will override any error that it
  /// returns. [validator] will not be called unless [forceErrorText] is null.
  ///
  /// See also:
  ///
  /// * [InputDecoration.errorText], which is used to display error messages in the text
  /// field's decoration without effecting the field's state. When [forceErrorText] is
  /// not null, it will override [InputDecoration.errorText] value.
  final String? forceErrorText;

  const SDFieldItemWidget({
    super.key,
    super.restorationId,
    required super.builder,
    required super.data,
    this.onSaved,
    this.forceErrorText,
  });
}
