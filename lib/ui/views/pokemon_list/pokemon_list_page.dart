import 'package:flutter/material.dart';
import 'package:pokedex/ui/components/pokemon_card.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const PokemonListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //leading: Icon(),
      ),
      body: GridView.count(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          PockemonCard(
            name: 'Luisa',
            urlImage: 'assets/images/transparente.png',
          ),
        ],
      ),
    );
  }
}
