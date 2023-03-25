import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../components/modal_alert.dart';

class Sliding extends StatelessWidget {
  final Widget content;
  final dynamic editFunc;
  final dynamic deleteFunc;
  final BuildContext cntxt;
  final String hash;

  const Sliding(
      {Key? key,
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
            onPressed: (context) => editFunc(cntxt),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit_square,
            label: 'Edit',
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          SlidableAction(
            onPressed: (context) => quickAlertConfirm(
              context,
              "you sure?",
              delete,
            ),
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

  delete() {
    deleteFunc(cntxt);
    Navigator.of(cntxt, rootNavigator: true).pop();
    quickAlertSuccess(cntxt, 'Deleted!');
  }
}
