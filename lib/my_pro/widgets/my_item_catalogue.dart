import 'package:beauty/my_pro/bloc/gestion_professional_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/my_pro/screens/sub/catalogue_for_pro_details.dart.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

class MyCatalogueItem extends StatelessWidget {
  final Catalogue catalogue;

  const MyCatalogueItem(
    this.catalogue,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return CatalogueForProDialog(
            catalogue: catalogue,
          );
        },
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          catalogueItemImage(catalogue: catalogue, context: context),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  toSvgIcon(
                      icon: Assets.iconsBookmark,
                      size: 32.0,
                      color: AppTheme.white),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${catalogue.price} €',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppTheme.white),
                  )
                ],
              )),
            ),
          ),
        ],
      ),
    );
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
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer,
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
          );
        },
        errorBuilder: (_, __, ___) => const Icon(Icons.error),
      );
}
