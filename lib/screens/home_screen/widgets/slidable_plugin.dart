import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quickalert/quickalert.dart';

import 'package:flutter_webapi_first_course/theme/theme_typography.dart';

class Sliding extends StatelessWidget {
  final Widget content;
  final dynamic editFunc;
  final dynamic deleteFunc;
  final BuildContext cntxt;
  final String hash;

  const Sliding({
    Key? key,
    required this.content,
    required this.editFunc,
    required this.deleteFunc,
    required this.cntxt,
    required this.hash})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: UniqueKey(),
        closeOnScroll: false,

        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.42,
          children: [
            SlidableAction(
              onPressed: funcOne,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              icon: Icons.edit_square,
              label: 'Edit',
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            SlidableAction(
              onPressed: quickAlert,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Colors.white,
              icon: Icons.delete_sharp,
              label: 'Delete',
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ],
        ),
        child: content,
      );
  }

  funcOne(BuildContext context) {
    return editFunc(cntxt);
  }

  quickAlert(BuildContext context) {
    QuickAlert.show(
      type: QuickAlertType.confirm,
      context: context,
      widget: Text('you sure?', style: ThemeTypography.rajdhaniPrimary),

      title: '_____________',
      titleColor: Theme.of(context).colorScheme.primary,

      cancelBtnText: 'not like that',
      cancelBtnTextStyle: ThemeTypography.abelWatermelon,

      confirmBtnText: 'hell yeah',
      confirmBtnTextStyle: ThemeTypography.abelWhite,
      confirmBtnColor: Theme.of(context).colorScheme.primary,

      animType: QuickAlertAnimType.slideInUp,

      onConfirmBtnTap: (() {
        deleteFunc(cntxt);
        Navigator.of(cntxt, rootNavigator: true).pop();
        QuickAlert.show(
            context: cntxt,
            type: QuickAlertType.success,
            text: 'Deleted!'
        );
      }),
    );
  }

}

