import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/professional/screens/sub/catalogue_for_user_details.dart.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

class CatalogueItem extends StatelessWidget {
  final Catalogue catalogue;

  const CatalogueItem(
    this.catalogue,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return CatalogueForUserDialog(
            catalogue: catalogue,
          );
        },
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          catalogueItemImage(catalogue: catalogue, context: context),
        ],
      ),
    );
  }
}

catalogueItemImage(
        {required BuildContext context, required Catalogue catalogue}) =>
    Image(
      image: context
          .read<AppCacheManager>()
          .getImage(catalogue.realisationFiles.first.filePath),
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
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      strokeWidth: 2.0,
                    ),
                  ),
                ),
        );
      },
      errorBuilder: (_, __, ___) => const Icon(Icons.error),
    );
