import 'package:flutter/cupertino.dart';
import 'package:form_framework/dispatcher/sd_dispatcher.dart';

class SDGenerator extends StatefulWidget {
  final Map<String, dynamic> schema;
  final Function() init;
  final Function() dispose;

  const SDGenerator({
    super.key,
    required this.init,
    required this.dispose,
    required this.schema,
  });

  @override
  State<StatefulWidget> createState() => SDGeneratorState();
}

class SDGeneratorState extends State<SDGenerator> {
  @override
  void initState() {
    widget.init();
    super.initState();
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
