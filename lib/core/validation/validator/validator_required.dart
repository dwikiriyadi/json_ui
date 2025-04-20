import 'package:json_ui/core/validation/validator.dart';

class RequiredValidator extends Validator {
  RequiredValidator({required super.data});

  @override
  String? call<T>({required T value}) {
    if (value == null) {
      return data["message"];
    }

    // For string values, check if they're empty
    if (value is String && value.trim().isEmpty) {
      return data["message"];
    }

    return null;
  }
}
