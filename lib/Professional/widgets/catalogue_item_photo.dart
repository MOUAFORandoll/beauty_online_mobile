import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

class CatalogueItemPhoto extends StatefulWidget {
  final Catalogue catalogue;

  const CatalogueItemPhoto({
    super.key,
    required this.catalogue,
  });

  @override
  State<CatalogueItemPhoto> createState() => _CatalogueItemPhotoState();
}

class _CatalogueItemPhotoState extends State<CatalogueItemPhoto> {
  
  @override
  Widget build(BuildContext context) {
     
    return Image(
      image: context.read<AppCacheManager>().getImage(
         widget. catalogue.realisationFiles.isEmpty
              ? 'null'
              :  widget.catalogue.realisationFiles.first.filePath),
      fit: BoxFit.cover,
      width: double.infinity,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame != null) return child;
        return Container(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          child: wasSynchronouslyLoaded
              ? child
              : const Center(
                  child: SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                ),
        );
      },
      errorBuilder: (_, __, ___) => const Icon(Icons.error),
    );
  }
}
