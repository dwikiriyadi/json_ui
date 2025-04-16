part of "sd_item_widget.dart";

abstract class SDItemState<T> extends State<SDItemWidget<T>>
    with RestorationMixin {
  late String key = widget.data["key"];

  late T? _value = widget.data["state"]["value"];

  T? get value => _value;

  late bool isVisible = widget.data["state"]["is_visible"] ?? true;

  void setValue(T? value) {
    _value = value;
  }

  void setIsVisible(bool value) {
    setState(() {
      isVisible = value;
    });
  }

  late Function() onClick;

  void addOnClick(Function() block) {
    onClick = block;
  }

}
