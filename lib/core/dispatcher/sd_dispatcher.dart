import 'package:json_ui/core/widget/sd_item_widget.dart';

typedef SDRender = SDItemWidget Function(Map<String, dynamic>);

class SDDispatcher {
  static final Map<String, SDRender> _renderers = {};

  static void register({
    required String componentName,
    required SDRender widget,
  }) {
    _renderers[componentName] = widget;
  }

  static SDItemWidget? render({required Map<String, dynamic> item}) {
    return _renderers[item["widget"]]?.call(item);
  }

  static void clear() {
    _renderers.clear();
  }
}
