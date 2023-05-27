import 'package:flutter/material.dart';

class WallpaperCard extends StatelessWidget {
  final String imageUrl;
  final String herotag;

  const WallpaperCard({
    Key? key,
    required this.imageUrl,
    required this.herotag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Hero(
          tag: herotag,
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 0.5,
            maxScale: 4,
            child: Image.network(
              imageUrl,
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
                return const Center(
                  child: Text('Something went wrong. Unable to load image'),
                );
              },
            ),
          ),
        ));
  }
}
