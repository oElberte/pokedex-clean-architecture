import 'package:flutter/material.dart';

Future<void> showError(BuildContext context, String error, {required VoidCallback onTap}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => SimpleDialog(
      children: [
        Column(
          children: [
            Text(error),
            TextButton(
              onPressed: onTap,
              child: const Text('Refresh'),
            ),
          ],
        ),
      ],
    ),
  );
}
