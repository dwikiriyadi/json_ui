part of "sd_item_widget.dart";

abstract class SDItemState<T extends SDItemWidget> extends State<T> {
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

  @override
  Widget build(BuildContext context) {
    // Get the generator state once and register with it if available
    final generatorState = SDGenerator.maybeOf(context);
    generatorState?.register(this);

    return widget.builder(context, this);
  }
}
