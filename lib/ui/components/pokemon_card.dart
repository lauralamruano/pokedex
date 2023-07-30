import 'package:flutter/material.dart';

class PockemonCard extends StatelessWidget {
  final String name;
  final String urlImage;

  const PockemonCard({required this.name, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Column(
        children: [
          Text(name, style: TextStyle(fontSize: 20),),
          Image.asset(urlImage)
        ],
      ),
    );
  }
}