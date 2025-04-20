part of 'sd_container_item_widget.dart';

abstract class SDContainerItemState<T extends SDContainerItemWidget> extends SDItemState<T> {
  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return const SizedBox.shrink();
    }

    // Get the generator state once and register with it if available
    final generatorState = SDGenerator.maybeOf(context);
    generatorState?.register(this);

    return widget.builder(context, this);
  }
}
