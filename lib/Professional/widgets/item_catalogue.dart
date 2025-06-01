import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/professional/screens/sub/catalogue_for_user_details.dart.dart';
import 'package:beauty/professional/widgets/catalogue_item_photo.dart';
import 'package:beauty/professional/widgets/catalogue_item_video.dart';
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
           catalogue.isVideo ?? false
                ? CatalogueItemVideo(
                    catalogue: catalogue,
                  )
                : CatalogueItemPhoto(catalogue: catalogue),

        ],
      ),
    );
  }
}
 