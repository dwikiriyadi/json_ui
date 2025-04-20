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
          return Column(
            mainAxisAlignment: MainAxisAlignmentProperty.getMainAxisAlignment(
              state.widget.data["property"]?["main_axis_alignment"],
            ),
            crossAxisAlignment:
                CrossAxisAlignmentProperty.getCrossAxisAlignment(
                  state.widget.data["property"]?["cross_axis_alignment"],
                ),
            mainAxisSize: MainAxisSizeProperty.getMainAxisSize(
              state.widget.data["property"]?["main_axis_size"],
            ),
            children:
                (state.widget.data["children"] as List? ?? [])
                    .map((item) => SDDispatcher.render(item: item))
                    .whereType<Widget>()
                    .toList(),
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
  // No need to override build as it's already implemented in SDContainerItemState
}
