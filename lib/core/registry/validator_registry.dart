import 'package:json_ui/core/dispatcher/validator_dispatcher.dart';
import 'package:json_ui/core/validation/validator/validator_required.dart';

class ValidatorRegistry {
  static void register() {
    // Register the RequiredValidator
    ValidatorDispatcher.register(
      name: "required",
      factory: (data) => RequiredValidator(data: data),
    );
    
    // Register other validators here
  }
}