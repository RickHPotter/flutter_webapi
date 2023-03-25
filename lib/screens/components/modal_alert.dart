import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../theme/theme_typography.dart';

quickAlertSuccess(BuildContext context, String text,
    {String title = "Success"}) {
  QuickAlert.show(
      context: context, type: QuickAlertType.success, title: title, text: text);
}

quickAlertError(BuildContext context, String text, {String title = ""}) {
  QuickAlert.show(
      context: context, type: QuickAlertType.error, title: title, text: text);
}

quickAlertInfo(BuildContext context, String text,
    {String title = "", Color confirmBtnColor = Colors.blue}) {
  QuickAlert.show(
      context: context, type: QuickAlertType.info, title: title, text: text);
}

quickAlertConfirm(BuildContext context, String text, dynamic onConfirmBtnTap,
    {String title = "_____________", Color confirmBtnColor = Colors.blue}) {
  QuickAlert.show(
      type: QuickAlertType.confirm,
      context: context,
      widget: Text(text, style: ThemeTypography.rajdhaniPrimary),
      title: title,
      titleColor: Theme.of(context).colorScheme.primary,
      cancelBtnText: 'not like that',
      cancelBtnTextStyle: ThemeTypography.abelWatermelon,
      confirmBtnText: 'hell yeah',
      confirmBtnTextStyle: ThemeTypography.abelWhite,
      confirmBtnColor: Theme.of(context).colorScheme.primary,
      animType: QuickAlertAnimType.slideInUp,
      onConfirmBtnTap: onConfirmBtnTap);
}
