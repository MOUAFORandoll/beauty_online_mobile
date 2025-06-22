import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/widgets/app_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:video_player/video_player.dart';

class ActuItemVideo extends StatefulWidget {
  final Actu actu;
  final VideoPlayerController controller;

  const ActuItemVideo({
    super.key,
    required this.actu,
    required this.controller,
  });

  @override
  State<ActuItemVideo> createState() => _ActuItemVideoState();
}

class _ActuItemVideoState extends State<ActuItemVideo> {
  Widget _buildThumbnail() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: widget.actu.video!.thumbnail.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(fit: StackFit.expand, children: [
                Image(
                  image: context
                      .read<AppCacheManager>()
                      .getImage(widget.actu.video!.thumbnail),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (frame != null) return child;
                    return Container(
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      child: wasSynchronouslyLoaded
                          ? child
                          : const Center(
                              child: SizedBox(
                                height: 16,
                                width: 16,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2.0),
                              ),
                            ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholder();
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return _buildLoadingIndicator();
                  },
                ),
              ]))
          // Image(
          //           image: context
          //               .read<AppCacheManager>()
          //               .getImage(widget.actu.video!.thumbnail),
          //           fit: BoxFit.cover,
          //           errorBuilder: (context, error, stackTrace) {
          //             return _buildPlaceholder();
          //           },
          //           loadingBuilder: (context, child, loadingProgress) {
          //             if (loadingProgress == null) return child;
          //             return _buildLoadingIndicator();
          //           },
          //         )
          : _buildPlaceholder(),
    );
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

  Widget _buildLoadingIndicator() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Chargement de la vidéo...',
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

  Widget _buildVideoPlayer() {
    if (widget.controller == null || !widget.controller!.value.isInitialized) {
      return _buildLoadingIndicator();
    }

    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AppVideoPlayer(
          controller: widget.controller,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Vidéo: ${widget.actu.video!.videoLink}');
    print('thumbnail: ${widget.actu.video!.thumbnail}');
    return Semantics(
      label: 'Vidéo: ${widget.actu.title ?? "Contenu vidéo"}',
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.controller?.value.isInitialized == true)
              _buildVideoPlayer()
            else
              _buildThumbnail(),
          ],
        ),
      ),
    );
  }
}

// Widget wrapper pour une utilisation simplifiée
class ActuVideoWidget extends StatelessWidget {
  final Actu actu;
  final VoidCallback? onTap;
  final bool autoPlay;
  final bool showControls;

  final VideoPlayerController controller;
  const ActuVideoWidget({
    super.key,
    required this.actu,
    this.onTap,
    this.autoPlay = false, // Par défaut false pour économiser la bande passante
    this.showControls = true,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ActuItemVideo(actu: actu, controller: controller),
    );
  }
}
