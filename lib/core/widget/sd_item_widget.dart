import 'package:flutter/widgets.dart';
import 'package:json_ui/core/sd_generator.dart';

part "sd_item_state.dart";

/// Signature for building the widget representing the form field.
///
/// Used by [SDItemWidget.builder].
typedef SDItemBuilder<T extends SDItemWidget> =
    Widget Function(BuildContext context, SDItemState<T> field);

abstract class SDItemWidget extends StatefulWidget {
  final Map<String, dynamic> data;

  /// Function that returns the widget representing this form field. It is
  /// passed the form field state as input, containing the current value and
  /// validation state of this field.
  final SDItemBuilder builder;

  /// Restoration ID to save and restore the state of the form field.
  ///
  /// Setting the restoration ID to a non-null value results in whether or not
  /// the form field validation persists.
  ///
  /// The state of this widget is persisted in a [RestorationBucket] claimed
  /// from the surrounding [RestorationScope] using the provided restoration ID.
  ///
  /// See also:
  ///
  ///  * [RestorationManager], which explains how state restoration works in
  ///    Flutter.
  final String? restorationId;

  const SDItemWidget({
    super.key,
    required this.data,
    required this.builder,
    this.restorationId,
  });
}
