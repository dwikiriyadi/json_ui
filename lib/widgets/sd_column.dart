import 'package:flutter/widgets.dart';
import 'package:form_framework/dispatcher/sd_dispatcher.dart';
import 'package:form_framework/widgets/core/sd_item_state.dart';
import 'package:form_framework/widgets/core/sd_item_widget.dart';

class SDColumn extends SDItemWidget {
  const SDColumn({super.key, required super.data});

  @override
  State<StatefulWidget> createState() => SDColumnState();
}

class SDColumnState extends SDItemState {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: widget.data["property"]["spacing"] ?? 0.0,
      children:
          (widget.data["children"] as List)
              .map((item) => SDDispatcher.render(item: item) as Widget)
              .toList(),
    );
  }

  @override
  // TODO: implement restorationId
  String? get restorationId => throw UnimplementedError();

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // TODO: implement restoreState
  }
}
