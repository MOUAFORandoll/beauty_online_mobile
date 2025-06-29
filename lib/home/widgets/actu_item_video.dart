import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potatoes/libs.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
class ActuVideoPlayer extends StatelessWidget {
  final Actu? actu;
  final Catalogue? catalogue;
  final VideoPlayerController? controller;

  const ActuVideoPlayer({
    super.key,
    this.actu,
    this.catalogue,
    this.controller,
  });

  const ActuVideoPlayer.fromActu({
    super.key,
    required Actu this.actu,
    required VideoPlayerController this.controller,
  }) : catalogue = null;

  const ActuVideoPlayer.fromCatalogue({
    super.key,
    required Catalogue this.catalogue,
    required VideoPlayerController this.controller,
  }) : actu = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return _buildThumbnailState(context);
    }

    return _buildVideoPlayer(context);
  }

  Widget _buildThumbnailState(BuildContext context) {
    final String? thumbnailUrl =
        actu?.video?.thumbnail ?? catalogue?.video?.thumbnail ?? '';
    final imageProvider =
        context.read<AppCacheManager>().getImage(thumbnailUrl!);

    return Stack(
      fit: StackFit.expand,
      children: [
        Image(
          fit: BoxFit.fill,
          image: imageProvider,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
            size: 32,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPlayer(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        VideoPlayer(controller!),
      ],
    );
  }
}
extension ActuVideoPlayerExtension on Actu {
  Widget toVideoPlayer({
    required VideoPlayerController controller,
  }) {
    return ActuVideoPlayer.fromActu(
      actu: this,
      controller: controller,
    );
  }
}

extension CatalogueVideoPlayerExtension on Catalogue {
  Widget toVideoPlayer({
    required VideoPlayerController controller,
  }) {
    return ActuVideoPlayer.fromCatalogue(
      catalogue: this,
      controller: controller,
    );
  }
}
