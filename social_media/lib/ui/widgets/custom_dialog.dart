import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.white,
      title: const Text('Delete post',
          style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
            OutlinedButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => super.widget)),
                child: const Text('Confirm')),
          ],
        )
      ],
    );
  }
}
