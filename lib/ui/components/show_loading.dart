import 'package:flutter/material.dart';

import './loading_indicator.dart';

Future<void> showLoading(BuildContext context) async {
  await Future.delayed(Duration.zero);
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      // insetPadding: const EdgeInsets.fromLTRB(110, 320, 110, 320),
      child: LoadingIndicator(),
    ),
  );
  //.timeout(const Duration(seconds: 10), onTimeout: () => hideLoading(context));
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}
