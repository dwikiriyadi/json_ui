import 'package:json_ui/core/validation/validator.dart';

typedef ValidatorFactory = Validator Function(Map<String, dynamic>);

class ValidatorDispatcher {
  static final Map<String, ValidatorFactory> _registered = {};

  static void register({
    required String name,
    required ValidatorFactory factory,
  }) {
    _registered[name] = factory;
  }

  static Validator? resolve(Map<String, dynamic> data) {
    return _registered[data["type"]]?.call(data);
  }

  static void clear() {
    _registered.clear();
  }
}
