part of "sd_item_widget.dart";

abstract class SDItemState<T> extends State<SDItemWidget>
    with RestorationMixin {
  late String key = widget.data["key"];

  late bool isVisible = widget.data["state"]["is_visible"] ?? true;

  void setIsVisible(bool value) {
    setState(() {
      isVisible = value;
    });
  }
}
