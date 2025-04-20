import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_ui/core/dispatcher/sd_dispatcher.dart';
import 'package:json_ui/core/widget/sd_item_widget.dart';

// class SDColumn extends SDItemWidget {
//   const SDColumn({super.key, required super.data, super.restorationId}) : super(
//     builder: (SDItemState<SDColumn> state) {
//       return Column(
//         spacing: widget.data["property"]["spacing"] ?? 0.0,
//         children:
//         (widget.data["children"] as List)
//             .map((item) => SDDispatcher.render(item: item) as Widget)
//             .toList(),
//       );
//     }
//   );
//
//   static void register() {
//     SDDispatcher.register(
//       componentName: "column",
//       widget: (data) => SDColumn(data: data),
//     );
//   }
//
//   @override
//   State<StatefulWidget> createState() => SDColumnState();
// }
//
// class SDColumnState extends SDItemState<SDColumn> {
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }
