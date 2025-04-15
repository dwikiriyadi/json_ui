import 'package:flutter/widgets.dart';

abstract class SDItemWidget<T> extends StatefulWidget {
  final Map<String, dynamic> data;

  const SDItemWidget({super.key, required this.data});
}
