import 'package:flutter/material.dart';

class RowNameAndButtons extends StatelessWidget {
  const RowNameAndButtons({
    Key? key,
    required this.name,
    required this.icon,
    required this.onFavoritePress,
  }) : super(key: key);

  final String name;
  final Widget icon;
  final void Function() onFavoritePress;

  @override
  Widget build(BuildContext context) {
    //TODO: Implement scroll back to index on pop and onTap directly on next or previous Pokémon
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 34,
          ),
        ),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: onFavoritePress,
          icon: icon,
        ),
      ],
    );
  }
}