import 'package:flutter/material.dart';

Color getPokemonColor(String type) {
  switch (type.toLowerCase()) {
    case 'normal':
      return const Color.fromRGBO(168, 168, 120, 1);
    case 'fighting':
      return const Color.fromRGBO(192, 48, 40, 1);
    case 'flying':
      return const Color.fromRGBO(168, 144, 240, 1);
    case 'poison':
      return const Color.fromRGBO(160, 64, 160, 1);
    case 'ground':
      return const Color.fromRGBO(224, 192, 104, 1);
    case 'rock':
      return const Color.fromRGBO(184, 161, 56, 1);
    case 'bug':
      return const Color.fromRGBO(168, 184, 32, 1);
    case 'ghost':
      return const Color.fromRGBO(112, 88, 152, 1);
    case 'steel':
      return const Color.fromRGBO(184, 184, 208, 1);
    case 'fire':
      return const Color.fromRGBO(250, 108, 108, 1);
    case 'water':
      return const Color.fromRGBO(104, 144, 240, 1);
    case 'grass':
      return const Color.fromRGBO(72, 207, 178, 1);
    case 'electric':
      return const Color.fromRGBO(255, 206, 75, 1);
    case 'psychic':
      return const Color.fromRGBO(248, 88, 136, 1);
    case 'ice':
      return const Color.fromRGBO(152, 216, 216, 1);
    case 'dragon':
      return const Color.fromRGBO(112, 56, 248, 1);
    case 'dark':
      return const Color.fromRGBO(112, 88, 72, 1);
    case 'fairy':
      return const Color.fromRGBO(238, 153, 172, 1);
    default:
      return const Color.fromRGBO(168, 168, 120, 1);
  }
}