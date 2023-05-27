import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool? isNetworkImage;

  const GridCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      this.isNetworkImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black, // Background color of the card
      elevation: 4.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 0.5, color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image with black tint
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.white, width: 1),
          //     borderRadius: Border,
          //     color: Theme.of(context).primaryColor,
          //   ),
          // ),
          // Opacity(
          //   opacity: 0.5,
          //   child: isNetworkImage ?? true
          //       ? Image.network(
          //           imageUrl,
          //           fit: BoxFit.cover,
          //         )
          //       : Image.asset(
          //           imageUrl,
          //           fit: BoxFit.cover,
          //         ),
          // ),
          // Title text at center
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white, // Text color
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
