import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:potatoes/libs.dart';

extension ImageUtils on Image {
  fullScreen(context) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => FullScreenMedia(image: this.image),
            ),
          );
        },
        child: this,
      );
}

class FullScreenMedia extends StatelessWidget {
  final ImageProvider image;

  const FullScreenMedia({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: image.hashCode,
          child: PhotoView(
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            imageProvider: image,
          ),
        ),
      ),
    );
  }
}
