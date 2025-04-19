import 'package:json_ui/core/dispatcher/validator_dispatcher.dart';
import 'package:json_ui/core/validation/model/validator_result.dart';
import 'package:json_ui/core/validation/validator.dart';
import 'package:json_ui/core/widget/sd_item_widget.dart';

part "sd_field_item_state.dart";

abstract class SDFieldItemWidget<T> extends SDItemWidget {
  const SDFieldItemWidget({
    super.key,
    required super.data,
    super.restorationId,
  });
}
