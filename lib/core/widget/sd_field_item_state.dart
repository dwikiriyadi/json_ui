part of "sd_field_item_widget.dart";

abstract class SDFieldItemState<T> extends SDItemState<SDFieldItemWidget<T>>
    with RestorationMixin {
  final FocusNode focusNode = FocusNode();

  final RestorableBool _hasInteractedByUser = RestorableBool(false);

  /// Returns true if the user has modified the value of this field.
  ///
  /// This only updates to true once [didChange] has been called and resets to
  /// false when [reset] is called.
  bool get hasInteractedByUser => _hasInteractedByUser.value;

  late T? _value = widget.data["state"]["value"];

  T? get value => _value;

  /// Sets the value associated with this form field.
  ///
  /// This method should only be called by subclasses that need to update
  /// the form field value due to state changes identified during the widget
  /// build phase, when calling `setState` is prohibited. In all other cases,
  /// the value should be set by a call to [didChange], which ensures that
  /// `setState` is called.
  @protected
  void setValue(T? value) {
    _value = value;
  }

  /// Updates this field's state to the new value. Useful for responding to
  /// child widget changes, e.g. [Slider]'s [Slider.onChanged] argument.
  ///
  /// Triggers the [SDGenerator.onChanged] callback and, if [SDGenerator.autovalidateMode] is
  /// [AutovalidateMode.always] or [AutovalidateMode.onUserInteraction],
  /// revalidates all the fields of the form.
  void didChange(T? value) {
    setState(() {
      _value = value;
      _hasInteractedByUser.value = true;
    });
    SDGenerator.maybeOf(context)?.fieldDidChange();
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

  late AutovalidateMode autovalidateMode = AutovalidateMode.values.firstWhere(
    (element) => element.name == widget.data["property"]["auto_validate_mode"],
  );

  late List<Validator> validators =
      (widget.data["validators"] as List<Map<String, dynamic>>)
          .map((element) => ValidatorDispatcher.resolve(element))
          .whereType<Validator>()
          .toList();

  bool _isValid = true;

  bool get isValid => _isValid;

  late RestorableStringN _errorMessage;

  /// The current validation error returned by the [SDFieldItemState.validators]
  /// callback, or the manually provided error message using the
  /// [FormField.forceErrorText] property.
  ///
  /// This property is automatically updated when [validate] is called and the
  /// [SDFieldItemState.validators] callback is invoked, or If [FormField.forceErrorText] is set
  /// directly to a non-null value.
  String? get errorMessage => _errorMessage.value;

  /// True if this field has any validation errors.
  bool get hasError => _errorMessage.value != null;

  /// Calls the [FormField]'s onSaved method with the current value.
  void save() {
    widget.onSaved?.call(value);
  }

  /// Resets the field to its initial value.
  void reset() {
    setState(() {
      _value = widget.data["state"]["value"];
      _hasInteractedByUser.value = false;
      _errorMessage.value = null;
    });
    SDGenerator.maybeOf(context)?.fieldDidChange();
  }

  void validate() {
    _isValid = true;
    _errorMessage.value = null;

    _validate((result) {
      _isValid = false;
      _errorMessage.value = result;
    });
  }

  void _validate(void Function(String) block) {
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
    _errorMessage.value = message;
  }

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_errorMessage, "error_message");
    registerForRestoration(_hasInteractedByUser, 'has_interacted_by_user');
  }

  @protected
  @override
  void initState() {
    super.initState();
    _errorMessage = RestorableStringN(widget.forceErrorText);
  }

  @protected
  @override
  void didUpdateWidget(SDFieldItemWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.forceErrorText != oldWidget.forceErrorText) {
      _errorMessage.value = widget.forceErrorText;
    }
  }

  @protected
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    switch (SDGenerator.maybeOf(context)?.widget.autovalidateMode) {
      case AutovalidateMode.always:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // If the form is already validated, don't validate again.
          if (isEnable && !hasError && !isValid) {
            validate();
          }
        });
      case AutovalidateMode.onUnfocus:
      case AutovalidateMode.onUserInteraction:
      case AutovalidateMode.disabled:
      case null:
        break;
    }
  }

  @override
  void dispose() {
    _errorMessage.dispose();
    focusNode.dispose();
    _hasInteractedByUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the generator state once to avoid multiple lookups
    final generatorState = SDGenerator.maybeOf(context);

    if (isEnable) {
      switch (autovalidateMode) {
        case AutovalidateMode.always:
          validate();
        case AutovalidateMode.onUserInteraction:
          if (_hasInteractedByUser.value) {
            validate();
          }
        case AutovalidateMode.onUnfocus:
        case AutovalidateMode.disabled:
          break;
      }
    }

    // Register with the generator if available
    generatorState?.register(this);

    // Check if we need to wrap with Focus for onUnfocus validation
    final generatorAutovalidateMode = generatorState?.widget.autovalidateMode;
    final needsFocusWrapper = 
        (generatorAutovalidateMode == AutovalidateMode.onUnfocus && 
         autovalidateMode != AutovalidateMode.always) || 
        autovalidateMode == AutovalidateMode.onUnfocus;

    if (needsFocusWrapper) {
      return Focus(
        canRequestFocus: false,
        skipTraversal: true,
        onFocusChange: (bool value) {
          if (!value) {
            setState(() {
              validate();
            });
          }
        },
        focusNode: focusNode,
        child: widget.builder(context, this),
      );
    }

    return widget.builder(context, this);
  }
}
