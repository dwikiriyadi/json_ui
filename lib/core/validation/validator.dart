import 'package:json_ui/core/validation/model/validator_result.dart';

abstract class Validator {
  final Map<String, dynamic> data;

  Validator({required this.data});

  ValidatorResult? call<T>({required T value});
}
