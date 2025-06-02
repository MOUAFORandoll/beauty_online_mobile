import 'dart:developer';

import 'package:beauty/common/bloc/select_realisation_cubit.dart';
import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/photo_full.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/app_video_player.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/item_pro.dart';
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:beauty/professional/screens/sub/agenda_pro.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class ActuPhotoComponent extends StatefulWidget { 
  @override
  State<ActuPhotoComponent> createState() => _ActuPhotoComponentState();
}

class _ActuPhotoComponentState extends State<ActuPhotoComponent>
    with CompletableMixin {
  int _currentCarouselIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  late final actuCubit = context.read<ActuCubit>();

  @override
  Widget build(BuildContext context) {
    final actu = actuCubit.actu;

    return Stack(
      children: [
        // Carousel d'images
        actu.realisationFiles.isNotEmpty
            ? CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.6,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  enableInfiniteScroll: actu.realisationFiles.length > 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentCarouselIndex = index;
                    });
                  },
                ),
                items: actu.realisationFiles.map((file) {
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
        if (actu.realisationFiles.length > 1)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actu.realisationFiles.asMap().entries.map((entry) {
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
