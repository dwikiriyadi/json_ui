import 'package:flutter/widgets.dart';

/// A mixin that provides onPressed event handling capabilities to widget states.
///
/// This mixin allows widget states to register onPressed event handlers and trigger
/// onPressed events. It is designed to be used by widget states that need to handle
/// press events, such as buttons.
///
/// Example usage:
///
/// ```dart
/// class MyButtonState extends State<MyButton> with SDPressed {
///   @override
///   Widget build(BuildContext context) {
///     return ElevatedButton(
///       onPressed: () => triggerOnPressed(),
///       child: Text('Press me'),
///     );
///   }
/// }
///
/// // In SDGenerator.manageEvent:
/// void manageEvent(SDGeneratorState state) {
///   // Get the button state
///   final buttonState = state.stateOf<MyButtonState>("button1");
///   
///   // Add an event handler for the button press
///   buttonState.addOnPressedEvent(() {
///     print('Button pressed!');
///     // Perform actions when the button is pressed
///   });
/// }
/// ```
///
/// This approach allows for a clean separation of UI and event handling logic.
/// The UI components trigger events, and the event handlers are registered separately.
mixin SDPressed<T extends StatefulWidget> on State<T> {
  /// The function to be called when the onPressed event is triggered.
  Function? _onPressedHandler;

  /// Add an event handler for the onPressed event.
  ///
  /// The [handler] is a function that will be called when the onPressed event is triggered.
  ///
  /// Example:
  /// ```dart
  /// addOnPressedEvent(() {
  ///   print('Button pressed!');
  /// });
  /// ```
  void addOnPressedEvent(Function handler) {
    _onPressedHandler = handler;
  }

  /// Trigger the onPressed event.
  ///
  /// This method should be called when the widget is pressed.
  ///
  /// Example:
  /// ```dart
  /// ElevatedButton(
  ///   onPressed: () => triggerOnPressed(),
  ///   child: Text('Press me'),
  /// );
  /// ```
  void triggerOnPressed() {
    if (_onPressedHandler != null) {
      _onPressedHandler!();
    }
  }
}