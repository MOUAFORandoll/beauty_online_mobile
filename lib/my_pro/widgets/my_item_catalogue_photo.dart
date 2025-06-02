import 'dart:developer';

import 'package:beauty/common/bloc/select_realisation_cubit.dart';
import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/photo_full.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/app_video_player.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/item_pro.dart';
import 'package:beauty/professional/screens/sub/agenda_pro.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class MyItemCataloguePhoto extends StatelessWidget {
  final Catalogue catalogue;

  MyItemCataloguePhoto(
    this.catalogue,
  );

  @override
  Widget build(BuildContext context) {
    return Image(
      image: context.read<AppCacheManager>().getImage(
          catalogue.realisationFiles.isEmpty
              ? 'null'
              : catalogue.realisationFiles.first.filePath),
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
