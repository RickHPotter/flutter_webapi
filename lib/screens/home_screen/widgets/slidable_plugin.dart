import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_webapi_first_course/theme/theme_typography.dart';
import 'package:quickalert/quickalert.dart';

class Sliding extends StatelessWidget {
  final Widget content;
  final dynamic editFunc;
  final dynamic deleteFunc;
  final BuildContext cntxt;
  final String id;

  const Sliding({
    Key? key,
    required this.content,
    required this.editFunc,
    required this.deleteFunc,
    required this.cntxt,
    required this.id})
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
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit_square,
              label: 'Edit',
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            SlidableAction(
              onPressed: quickAlert,
              backgroundColor: const Color(0xFFFE4A49),
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
      widget: Text(
          'you sure?',
          style: ThemeTypography.gFonts(
              'Rajdhani',
              24,
              FontWeight.w500,
              const Color.fromRGBO(0, 48, 73, 1)
          ),
      ),

      title: '_____________',
      titleColor: const Color.fromRGBO(0, 48, 73, 1),

      cancelBtnText: 'not like that',
      cancelBtnTextStyle: ThemeTypography.gFonts('Abel', 16, FontWeight.w600, const Color(0xFFFE4A49)),

      confirmBtnText: 'hell yeah',
      confirmBtnTextStyle: ThemeTypography.gFonts('Abel', 16, FontWeight.w600, Colors.white),
      confirmBtnColor: const Color.fromRGBO(0, 48, 73, 1),

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

