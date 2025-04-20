import 'package:flutter/material.dart';
import 'package:json_ui/core/sd_generator.dart';
import 'package:json_ui/core/widget/sd_field_item_widget.dart';
import 'package:json_ui/widgets/sd_column.dart';
import 'package:json_ui/widgets/sd_text.dart';
import 'package:json_ui/widgets/sd_text_field.dart';
import 'package:json_ui/widgets/sd_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Example schema based on example.json
  final Map<String, dynamic> _schema = {
    "key": "root_column",
    "widget": "column",
    "property": {
      "main_axis_alignment": "start",
      "cross_axis_alignment": "center",
      "main_axis_size": "max"
    },
    "state": {
      "is_visible": true
    },
    "children": [
      {
        "key": "example_text",
        "widget": "text",
        "property": {
          "text": "Example Form",
          "font_size": 20.0,
          "font_weight": "bold",
          "text_align": "center"
        },
        "state": {
          "is_visible": true
        }
      },
      {
        "key": "name_text_field",
        "widget": "text_field",
        "property": {
          "label_text": "Name",
          "hint_text": "Enter your name",
          "helper_text": "Your full name",
          "border": "outline",
          "keyboard_type": "text",
          "text_input_action": "next",
          "auto_validate_mode": "onUserInteraction"
        },
        "state": {
          "value": "",
          "is_visible": true,
          "is_read_only": false,
          "is_enable": true
        },
        "validators": [
          {
            "type": "required",
            "message": "Name is required"
          }
        ]
      },
      {
        "key": "email_text_field",
        "widget": "text_field",
        "property": {
          "label_text": "Email",
          "hint_text": "Enter your email",
          "helper_text": "Your email address",
          "border": "outline",
          "keyboard_type": "emailAddress",
          "text_input_action": "next",
          "auto_validate_mode": "onUserInteraction"
        },
        "state": {
          "value": "",
          "is_visible": true,
          "is_read_only": false,
          "is_enable": true
        },
        "validators": [
          {
            "type": "required",
            "message": "Email is required"
          }
        ]
      },
      {
        "key": "phone_text_field",
        "widget": "text_field",
        "property": {
          "label_text": "Phone",
          "hint_text": "Enter your phone number",
          "helper_text": "Your phone number",
          "border": "outline",
          "keyboard_type": "phone",
          "text_input_action": "done",
          "auto_validate_mode": "onUserInteraction"
        },
        "state": {
          "value": "",
          "is_visible": true,
          "is_read_only": false,
          "is_enable": true
        },
        "validators": [
          {
            "type": "required",
            "message": "Phone number is required"
          }
        ]
      },
      {
        "key": "example_button",
        "widget": "button",
        "property": {
          "text": "Submit",
          "font_size": 16.0,
          "font_weight": "bold"
        },
        "state": {
          "is_visible": true,
          "is_enable": true
        }
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SDGenerator(
        schema: _schema,
        register: () {
          // Register all required components
          SDColumn.register();
          SDText.register();
          SDTextField.register();
          SDButton.register();
        },
        manageEvent: (generatorState) {
          // Add button press event to display textfield values in snackbar
          final buttonState = generatorState.stateOf<SDButtonState>("example_button");
          if (buttonState != null) {
            buttonState.addOnPressedEvent(() {
              final isValid = generatorState.validate();
              if (isValid) {
                // Get values from all text fields
                final nameState = generatorState.stateOf<SDFieldItemState<String>>("name_text_field");
                final emailState = generatorState.stateOf<SDFieldItemState<String>>("email_text_field");
                final phoneState = generatorState.stateOf<SDFieldItemState<String>>("phone_text_field");

                final name = nameState?.value ?? "No name entered";
                final email = emailState?.value ?? "No email entered";
                final phone = phoneState?.value ?? "No phone entered";

                // Display all values in snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Name: $name\nEmail: $email\nPhone: $phone"),
                    duration: const Duration(seconds: 5),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fix the validation errors")),
                );
              }
            });
          }
        },
      ),
    );
  }
}
