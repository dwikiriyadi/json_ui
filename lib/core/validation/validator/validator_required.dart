import 'package:json_ui/core/validation/model/validator_result.dart';
import 'package:json_ui/core/validation/validator.dart';

class RequiredValidator extends Validator {
  RequiredValidator({required super.data});

  @override
  ValidatorResult? call<T>({required T value}) {
    if (value != null) {
      return ValidatorResult(message: data["message"]);
    } else {
      return null;
    }
  }
}
