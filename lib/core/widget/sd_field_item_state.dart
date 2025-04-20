part of "sd_field_item_widget.dart";

abstract class SDFieldItemState<T> extends SDItemState with RestorationMixin {
  late T? _value = widget.data["state"]["value"];

  T? get value => _value;

  void setValue(T? value) {
    _value = value;
  }

  late bool _isEnable = widget.data["state"]["is_enable"] ?? true;

  bool get isEnable => _isEnable;

  void setEnable(bool value) {
    _isEnable = value;
  }

  late bool _isReadOnly = widget.data["state"]["is_read_only"] ?? true;

  bool get isReadOnly => _isReadOnly;

  void setReadOnly(bool value) {
    _isReadOnly = value;
  }

  late List<Validator> validators =
      (widget.data["validators"] as List<Map<String, dynamic>>)
          .map((element) => ValidatorDispatcher.resolve(element))
          .whereType<Validator>()
          .toList();

  bool _isValid = true;

  bool get isValid => _isValid;

  void setValid(bool value) {
    _isValid = value;
  }

  ValidatorResult? _errorMessage;

  ValidatorResult? get errorMessage => _errorMessage;

  void validate() {
    _isValid = true;
    _errorMessage = null;

    _validate((result) {
      _isValid = false;
      _errorMessage = result;
    });
  }

  void _validate(void Function(ValidatorResult) block) {
    if (isVisible) {
      for (var validator in validators) {
        final message = validator.call(value: value);
        if (message != null) {
          block(message);
          break;
        }
      }
    }
  }

  void validateFromApi(String message) {
    _isValid = false;
    _errorMessage = ValidatorResult(message: message);
  }

  late Function() onClick;

  void addOnClick(Function() block) {
    onClick = block;
  }
}
