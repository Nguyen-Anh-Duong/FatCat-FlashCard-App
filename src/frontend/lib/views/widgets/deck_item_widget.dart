import 'package:flutter/material.dart';

class DeckItemWidget extends StatelessWidget {
  final String name;
  final String description;
  const DeckItemWidget({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 250,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   width: 2,
          //   color: Color.fromRGBO(49, 58, 89, 1),
          // ),
        ),
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
