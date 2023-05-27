import 'package:flutter/material.dart';

class PreviewWallpaper extends StatelessWidget {
  const PreviewWallpaper({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: InteractiveViewer(
        panEnabled: true,
        minScale: 0.5,
        maxScale: 4,
        child: Image.network(
          image,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text('Error loading image : ${error.toString()}'),
            );
          },
        ),
      ),
    ));
  }
}
