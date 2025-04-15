import 'package:flutter/cupertino.dart';
import 'package:form_framework/widgets/core/sd_item_widget.dart';

abstract class SDItemState<T> extends State<SDItemWidget<T>>
    with RestorationMixin {

  late T? value = widget.data["state"]["value"];

  late bool isVisible = widget.data["state"]["is_visible"] ?? true;

  late Function() onClick;

  void addOnClick(Function() block) {
    onClick = block;
  }

  void setValue(T value) {
    setState(() {
      this.value = value;
    });
  }
}
