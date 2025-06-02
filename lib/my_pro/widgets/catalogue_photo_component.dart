import 'dart:developer';

import 'package:beauty/common/bloc/select_realisation_cubit.dart';
import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/photo_full.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class CataloguePhotoComponent extends StatefulWidget {
  final Catalogue catalogue;

  const CataloguePhotoComponent(this.catalogue);
  @override
  State<CataloguePhotoComponent> createState() =>
      _CataloguePhotoComponentState();
}

class _CataloguePhotoComponentState extends State<CataloguePhotoComponent>
    with CompletableMixin {
  int _currentCarouselIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Carousel d'images
        widget.catalogue.realisationFiles.isNotEmpty
            ? CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.6,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  enableInfiniteScroll:
                      widget.catalogue.realisationFiles.length > 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentCarouselIndex = index;
                    });
                  },
                ),
                items: widget.catalogue.realisationFiles.map((file) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32),
                          ),
                          child: Image(
                            fit: BoxFit.cover,
                            image: context
                                .read<AppCacheManager>()
                                .getImage(file.filePath),
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.error,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                              size: 32,
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ).fullScreen(context),
                        ),
                      );
                    },
                  );
                }).toList(),
              )
            : Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.white54,
                    size: 50,
                  ),
                ),
              ),

        // Indicateurs de carrousel
        if (widget.catalogue.realisationFiles.length > 1)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.catalogue.realisationFiles
                  .asMap()
                  .entries
                  .map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(
                        _currentCarouselIndex == entry.key ? 0.9 : 0.4,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
