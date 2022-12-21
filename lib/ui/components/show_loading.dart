import 'package:flutter/material.dart';

Future<void> showLoading(BuildContext context) async {
  await Future.delayed(Duration.zero);
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      // insetPadding: const EdgeInsets.fromLTRB(110, 320, 110, 320),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            'Loading...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
  //.timeout(const Duration(seconds: 10), onTimeout: () => hideLoading(context));
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}
