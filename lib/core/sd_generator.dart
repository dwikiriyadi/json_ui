import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_ui/core/dispatcher/sd_dispatcher.dart';
import 'package:json_ui/core/widget/sd_item_widget.dart';

class SDGenerator extends StatefulWidget {
  final Map<String, dynamic> schema;
  final Function() register;
  final Function(SDGeneratorState) manageEvent;
  final Function() dispose;

  const SDGenerator({
    super.key,
    required this.register,
    required this.manageEvent,
    required this.dispose,
    required this.schema,
  });

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
    final _SDGeneratorScope? scope = context.dependOnInheritedWidgetOfExactType<_SDGeneratorScope>();
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

  @override
  State<StatefulWidget> createState() => SDGeneratorState();
}

class SDGeneratorState extends State<SDGenerator> {
  int _generation = 0;
  bool _hasInteractedByUser = false;
  final Set<SDItemState<dynamic>> _items = <SDItemState<dynamic>>{};

  SDItemState stateOf<T>(String key) =>
      _items.firstWhere((item) => item.key == key);

  void _forceRebuild() {
    setState(() {
      ++_generation;
    });
  }

  @override
  void initState() {
    widget.register();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.manageEvent(this);
    });
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SDDispatcher.render(item: widget.schema) ?? SizedBox.shrink();
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
