import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/widgets/app_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potatoes/libs.dart'; 
import 'package:video_player/video_player.dart';

class CatalogueItemVideo extends StatefulWidget {
  final Catalogue catalogue;

  const CatalogueItemVideo({
    super.key,
    required this.catalogue,
  });

  @override
  State<CatalogueItemVideo> createState() => _CatalogueItemVideoState();
}

class _CatalogueItemVideoState extends State<CatalogueItemVideo>
    with AutomaticKeepAliveClientMixin {
  VideoPlayerController? _controller;
  VideoCubit? _videoCubit;
  bool _isInitializing = false;
  bool _hasError = false;
  String? _errorMessage;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didUpdateWidget(CatalogueItemVideo oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Réinitialiser si l'URL de la vidéo a changé
    if (oldWidget.catalogue.video != null) {
      if (oldWidget.catalogue.video!.videoLink != widget.catalogue.video!.videoLink) {
        _disposeController();
        _initializeVideo();
      }
    }
  }

  Future<void> _initializeVideo() async {
    if (widget.catalogue.video == null) {
      setState(() {
        _hasError = false;
      });
      return;
    }
    if (_isInitializing || widget.catalogue.video!.videoLink.isEmpty) return;

    setState(() {
      _isInitializing = true;
      _hasError = false;
      _errorMessage = null;
    });

    try {
      _videoCubit = context.read<VideoCubit>();

      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.catalogue.video!.videoLink),
        httpHeaders: {
          'User-Agent': 'Flutter Video Player',
        },
      );

      // Configuration du controller
      await _controller!.initialize();

      // Configuration des options

      await _controller!.setLooping(true);

      await _controller!.play();

      // Mise à jour du cubit
      _videoCubit?.set(_controller!);

      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    } catch (error) {
      debugPrint('Erreur initialisation vidéo: $error');

      if (mounted) {
        setState(() {
          _isInitializing = false;
          _hasError = true;
          _errorMessage = _getErrorMessage(error);
        });
      }
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('network')) {
      return 'Erreur de connexion réseau';
    } else if (error.toString().contains('format')) {
      return 'Format vidéo non supporté';
    } else {
      return 'Erreur lors du chargement de la vidéo';
    }
  }

  void _disposeController() {
    _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  Widget _buildThumbnail() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.56, // Ratio 16:9
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: widget.catalogue.video!.thumbnail?.isNotEmpty == true
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: context
                    .read<AppCacheManager>()
                    .getImage("    widget.catalogue.thumbnailUrl"),
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholder();
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _buildLoadingIndicator();
                },
              ),
            )
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

  Widget _buildErrorWidget() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.56,
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Erreur de chargement',
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                _initializeVideo();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return _buildLoadingIndicator();
    }

    final aspectRatio = _controller!.value.aspectRatio;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: screenWidth / aspectRatio,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: AppVideoPlayer(
            controller: _controller!,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Nécessaire pour AutomaticKeepAliveClientMixin

    return Semantics(
      label: 'Vidéo: ${widget.catalogue.title ?? "Contenu vidéo"}',
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contenu vidéo
            if (_hasError || widget.catalogue.video == null)
              _buildErrorWidget()
            else if (_isInitializing)
              _buildLoadingIndicator()
            else if (_controller?.value.isInitialized == true)
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
class CatalogueVideoWidget extends StatelessWidget {
  final Catalogue catalogue;
  final VoidCallback? onTap;
  final bool autoPlay;
  final bool showControls;

  const CatalogueVideoWidget({
    super.key,
    required this.catalogue,
    this.onTap,
    this.autoPlay = false, // Par défaut false pour économiser la bande passante
    this.showControls = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CatalogueItemVideo(
        catalogue: catalogue,
      ),
    );
  }
}
