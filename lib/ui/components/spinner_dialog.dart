import 'package:flutter/material.dart';

Future<void> showLoading(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => SimpleDialog(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Loading', textAlign: TextAlign.center),
          ],
        ),
      ],
    ),
  );
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
