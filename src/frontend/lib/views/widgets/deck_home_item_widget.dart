import 'package:FatCat/constants/colors.dart';
import 'package:flutter/material.dart';

class DeckHomeItemWidget extends StatelessWidget {
  final String name;
  final String description;
  final String userCreate;
  const DeckHomeItemWidget({
    super.key,
    required this.name,
    required this.description,
    required this.userCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.blackText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {},
        child: Container(
          // margin: EdgeInsets.all(0),
          // padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 99, 99, 99)
                  .withOpacity(0.25), // Border color
              width: 2, // Border width
            ),
            borderRadius: BorderRadius.circular(14), // Same as button radius
          ),
          width: 250,
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
      ),
    );
  }
}
