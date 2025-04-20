part of "sd_item_widget.dart";

abstract class SDItemState extends State<SDItemWidget> {
  late String key = widget.data["key"];

  late bool isVisible = widget.data["state"]["is_visible"] ?? true;

  void setIsVisible(bool value) {
    setState(() {
      isVisible = value;
    });
  }

  @override
  void deactivate() {
    SDGenerator.maybeOf(context)?.unregister(this);
    super.deactivate();
  }
}
