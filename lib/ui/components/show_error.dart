import 'package:flutter/material.dart';

Widget showError(String error, {required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.all(30),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: onTap,
            child: const Text(
              'Refresh',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    ),
  );
}
