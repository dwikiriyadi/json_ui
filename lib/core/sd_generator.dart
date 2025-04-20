import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_ui/core/dispatcher/sd_dispatcher.dart';
import 'package:json_ui/core/widget/sd_field_item_widget.dart';
import 'package:json_ui/core/widget/sd_item_widget.dart';

class SDGenerator extends StatefulWidget {
  final Map<String, dynamic> schema;
  final Function() register;
  final Function(SDGeneratorState) manageEvent;
  final AutovalidateMode autovalidateMode;

  const SDGenerator({
    super.key,
    required this.register,
    required this.manageEvent,
    required this.schema,
    this.canPop,
    this.onPopInvokedWithResult,
    this.onChanged,
    AutovalidateMode? autovalidateMode,
  }) : autovalidateMode = autovalidateMode ?? AutovalidateMode.disabled;

  /// Returns the [SDGeneratorState] of the closest [SDGenerator] widget which encloses the
  /// given context, or null if none is found.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// SDGeneratorState? generator = SDGenerator.maybeOf(context);
  /// generator?.save();
  /// ```
  ///
  /// Calling this method will create a dependency on the closest [SDGenerator] in the
  /// [context], if there is one.
  ///
  /// See also:
  ///
  /// * [SDGenerator.of], which is similar to this method, but asserts if no [SDGenerator]
  ///   ancestor is found.
  static SDGeneratorState? maybeOf(BuildContext context) {
    final _SDGeneratorScope? scope =
        context.dependOnInheritedWidgetOfExactType<_SDGeneratorScope>();
    return scope?._generatorState;
  }

  /// Returns the [SDGeneratorState] of the closest [SDGenerator] widget which encloses the
  /// given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// SDGeneratorState generator = SDGenerator.of(context);
  /// generator.save();
  /// ```
  ///
  /// If no [SDGenerator] ancestor is found, this will assert in debug mode, and throw
  /// an exception in release mode.
  ///
  /// Calling this method will create a dependency on the closest [SDGenerator] in the
  /// [context].
  ///
  /// See also:
  ///
  /// * [SDGenerator.maybeOf], which is similar to this method, but returns null if no
  ///   [SDGenerator] ancestor is found.
  static SDGeneratorState of(BuildContext context) {
    final SDGeneratorState? formState = maybeOf(context);
    assert(() {
      if (formState == null) {
        throw FlutterError(
          'SDGenerator.of() was called with a context that does not contain a SDGenerator widget.\n'
          'No SDGenerator widget ancestor could be found starting from the context that '
          'was passed to SDGenerator.of(). This can happen because you are using a widget '
          'that looks for a SDGenerator ancestor, but no such ancestor exists.\n'
          'The context used was:\n'
          '  $context',
        );
      }
      return true;
    }());
    return formState!;
  }

  /// {@macro flutter.widgets.PopScope.canPop}
  ///
  /// {@tool dartpad}
  /// This sample demonstrates how to use this parameter to show a confirmation
  /// dialog when a navigation pop would cause form data to be lost.
  ///
  /// ** See code in examples/api/lib/widgets/form/form.1.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [onPopInvokedWithResult], which also comes from [PopScope] and is often used in
  ///    conjunction with this parameter.
  ///  * [PopScope.canPop], which is what [Form] delegates to internally.
  final bool? canPop;

  /// {@macro flutter.widgets.navigator.onPopInvokedWithResult}
  ///
  /// {@tool dartpad}
  /// This sample demonstrates how to use this parameter to show a confirmation
  /// dialog when a navigation pop would cause form data to be lost.
  ///
  /// ** See code in examples/api/lib/widgets/form/form.1.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [canPop], which also comes from [PopScope] and is often used in
  ///    conjunction with this parameter.
  ///  * [PopScope.onPopInvokedWithResult], which is what [Form] delegates to internally.
  final PopInvokedWithResultCallback<Object?>? onPopInvokedWithResult;

  void _callPopInvoked(bool didPop, Object? result) {
    if (onPopInvokedWithResult != null) {
      onPopInvokedWithResult!(didPop, result);
      return;
    }
  }

  /// Called when one of the form fields changes.
  ///
  /// In addition to this callback being invoked, all the form fields themselves
  /// will rebuild.
  final VoidCallback? onChanged;

  @override
  State<StatefulWidget> createState() => SDGeneratorState();
}

class SDGeneratorState extends State<SDGenerator> {
  int _generation = 0;
  bool _hasInteractedByUser = false;
  final Set<SDItemState> _items = <SDItemState>{};
  late final Set<SDFieldItemState<dynamic>> _fields =
      _items.whereType<SDFieldItemState>().toSet();

  T? stateOf<T extends SDItemState>(String key) =>
      _items.firstWhere((item) => item.key == key) as T;

  // Called when a form field has changed. This will cause all form fields
  // to rebuild, useful if form fields have interdependencies.
  void _fieldDidChange() {
    widget.onChanged?.call();

    _hasInteractedByUser = _fields.any(
          (SDFieldItemState<dynamic> field) => field._hasInteractedByUser.value,
    );
    _forceRebuild();
  }

  void _forceRebuild() {
    setState(() {
      ++_generation;
    });
  }

  void register(SDItemState item) {
    _items.add(item);
  }

  void unregister(SDItemState item) {
    _items.remove(item);
  }

  @override
  void initState() {
    super.initState();
    widget.register();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.manageEvent(this);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canPop ?? true,
      onPopInvokedWithResult: widget._callPopInvoked,
      child: _SDGeneratorScope(
        generatorState: this,
        generation: _generation,
        child: SDDispatcher.render(item: widget.schema) ?? SizedBox.shrink(),
      ),
    );
  }
}

class _SDGeneratorScope extends InheritedWidget {
  const _SDGeneratorScope({
    required super.child,
    required SDGeneratorState generatorState,
    required int generation,
  }) : _generatorState = generatorState,
       _generation = generation;

  final SDGeneratorState _generatorState;

  /// Incremented every time a SDItem has changed. This lets us know when
  /// to rebuild the generator.
  final int _generation;

  /// The [SDGenerator] associated with this widget.
  SDGenerator get generator => _generatorState.widget;

  @override
  bool updateShouldNotify(_SDGeneratorScope old) =>
      _generation != old._generation;
}
