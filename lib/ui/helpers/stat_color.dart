import 'package:flutter/material.dart';

Color getStatColor(String stat) {
  switch (stat.toLowerCase()) {
    case 'hp':
      return const Color.fromARGB(255, 255, 35, 35);
    case 'atk':
      return const Color.fromARGB(255, 255, 189, 8);
    case 'def':
      return const Color.fromARGB(255, 8, 115, 255);
    case 'satk':
      return const Color.fromARGB(255, 255, 216, 110);
    case 'sdef':
      return const Color.fromARGB(255, 105, 170, 255);
    case 'spd':
      return const Color.fromARGB(255, 110, 110, 110);
    default:
      return const Color.fromARGB(255, 60, 146, 39);
  }
}
