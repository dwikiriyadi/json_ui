import 'package:flutter/material.dart';
import 'package:json_ui/core/sd_generator.dart';
import 'package:json_ui/core/widget/sd_item_widget.dart';

part 'sd_container_item_state.dart';

abstract class SDContainerItemWidget extends SDItemWidget {
  const SDContainerItemWidget({
    super.key,
    required super.data,
    super.restorationId,
    required super.builder,
  });
}
