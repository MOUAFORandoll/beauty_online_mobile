import 'dart:developer';

import 'package:beauty/common/bloc/select_realisation_cubit.dart';
import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/photo_full.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/app_video_player.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/item_pro.dart';
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:beauty/home/widgets/video_progress_bar.dart';
import 'package:beauty/professional/screens/sub/agenda_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

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
