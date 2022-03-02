import 'package:flutter/cupertino.dart';
import 'package:lang_and_dark/app/app_localization.dart';

extension StringExtension on String {
  String translateTo(BuildContext context) {
    return AppLocalization.of(context)!.translate(this);
  }
}
