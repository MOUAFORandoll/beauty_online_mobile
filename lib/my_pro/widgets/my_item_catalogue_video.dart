
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart'; 

class MyItemCatalogueVideo extends StatefulWidget {
  final Catalogue catalogue;

  const MyItemCatalogueVideo(
    this.catalogue,
  );
  @override
  State<MyItemCatalogueVideo> createState() =>
      _MyItemCatalogueVideoState();
}

class _MyItemCatalogueVideoState extends State<MyItemCatalogueVideo> {
  Widget _buildThumbnail() {
    return widget.catalogue.video!.thumbnail.isNotEmpty
        ? Image(
            image: context
                .read<AppCacheManager>()
                .getImage(widget.catalogue.video!.thumbnail),
            fit: BoxFit.cover,
            width: double.infinity,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (frame != null) return child;
              return Container(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                width: double.infinity,
                child: wasSynchronouslyLoaded
                    ? child
                    : Center(
                        child: SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator(
                            color: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                            strokeWidth: 2.0,
                          ),
                        ),
                      ),
              );
            },
            errorBuilder: (_, __, ___) => const Icon(Icons.error),
          )
        : _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 8),
            Text(
              'Aperçu vidéo non disponible',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    print('Vidéo: ${widget.catalogue.video!.videoLink}');
    print('thumbnail: ${widget.catalogue.video!.thumbnail}');
    return Semantics(
      label: 'Vidéo: ${widget.catalogue.title ?? "Contenu vidéo"}',
      child: _buildThumbnail(),
    );
  }
}
