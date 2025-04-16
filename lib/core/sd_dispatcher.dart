import 'package:json_ui/core/widget/sd_item_widget.dart';

typedef SDRender = SDItemWidget Function(Map<String, dynamic>);

class SDDispatcher {
  static Map<String, SDRender> renderers = {};

  static void register({
    required String componentName,
    required SDRender widget,
  }) {
    renderers[componentName] = widget;
  }

  static SDItemWidget? render({
    required Map<String, dynamic> item,
  }) {
    return renderers[item["widget"]]?.call(item);
  }

  static void clear() {
    renderers.clear();
  }
}
