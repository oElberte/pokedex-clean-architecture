import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../helpers/helpers.dart';

class PokemonStats extends StatelessWidget {
  const PokemonStats(this.onScreenPokemon, {Key? key}) : super(key: key);

  final PokemonViewModel onScreenPokemon;

  @override
  Widget build(BuildContext context) {
    //TODO: Add EXP to base stats
    return Container(
      padding: const EdgeInsets.only(bottom: 15,),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 5),
            child: Text(
              'Base stats',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Column(
            children: onScreenPokemon.stats
                .map(
                  (stat) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text(
                            stat.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            tween: Tween<double>(
                              begin: 0,
                              end: stat.stat / 255,
                            ),
                            builder: (context, value, _) => Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey,
                                    color: getStatColor(stat.name),
                                    minHeight: 20,
                                    value: value,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.lerp(
                                    Alignment.centerLeft,
                                    Alignment.centerRight,
                                    stat.stat <= 15
                                        ? value - 0.04
                                        : value - 0.08,
                                  )!,
                                  child: Text(
                                    stat.stat.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black38,
                                          offset: Offset(2, 2),
                                          blurRadius: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Text(
                          '255',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
