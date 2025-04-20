import 'package:flutter/widgets.dart';
import 'package:json_ui/core/dispatcher/sd_dispatcher.dart';
import 'package:json_ui/core/property/main_axis_alignment_property.dart';
import 'package:json_ui/core/property/cross_axis_alignment_property.dart';
import 'package:json_ui/core/property/main_axis_size_property.dart';
import 'package:json_ui/core/widget/sd_container_item_widget.dart';

class SDColumn extends SDContainerItemWidget {
  SDColumn({super.key, required super.data, super.restorationId})
    : super(
        builder: (context, state) {
          final columnState = state as SDColumnState;
          return Column(
            mainAxisAlignment: columnState.mainAxisAlignment,
            crossAxisAlignment: columnState.crossAxisAlignment,
            mainAxisSize: columnState.mainAxisSize,
            children: columnState.getChildren(),
          );
        },
      );

  static void register() {
    SDDispatcher.register(
      componentName: "column",
      widget: (data) => SDColumn(data: data),
    );
  }

  @override
  SDContainerItemState<SDColumn> createState() => SDColumnState();
}

class SDColumnState extends SDContainerItemState<SDColumn> {
  // Cached property values
  MainAxisAlignment? _cachedMainAxisAlignment;
  CrossAxisAlignment? _cachedCrossAxisAlignment;
  MainAxisSize? _cachedMainAxisSize;
  List<Widget>? _cachedChildren;

  // Property getters with memoization
  MainAxisAlignment get mainAxisAlignment {
    _cachedMainAxisAlignment ??= MainAxisAlignmentProperty.getMainAxisAlignment(
        widget.data["property"]?["main_axis_alignment"],
      );
    return _cachedMainAxisAlignment!;
  }

  CrossAxisAlignment get crossAxisAlignment {
    _cachedCrossAxisAlignment ??= CrossAxisAlignmentProperty.getCrossAxisAlignment(
        widget.data["property"]?["cross_axis_alignment"],
      );
    return _cachedCrossAxisAlignment!;
  }

  MainAxisSize get mainAxisSize {
    _cachedMainAxisSize ??= MainAxisSizeProperty.getMainAxisSize(
        widget.data["property"]?["main_axis_size"],
      );
    return _cachedMainAxisSize!;
  }

  List<Widget> getChildren() {
    // Note: We don't cache children because they need to be re-rendered
    // each time the build method is called to reflect any changes in child widgets
    return (widget.data["children"] as List? ?? [])
        .map((item) => SDDispatcher.render(item: item))
        .whereType<Widget>()
        .toList();
  }

  @override
  void dispose() {
    // Clear all cached properties to prevent memory leaks
    _cachedMainAxisAlignment = null;
    _cachedCrossAxisAlignment = null;
    _cachedMainAxisSize = null;
    _cachedChildren = null;

    super.dispose();
  }
}
