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

  const ActuItemVideo({
    super.key,
    required this.actu,
  });

  @override
  State<ActuItemVideo> createState() => _ActuItemVideoState();
}

class _ActuItemVideoState extends State<ActuItemVideo>
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
  void didUpdateWidget(ActuItemVideo oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Réinitialiser si l'URL de la vidéo a changé
    if (oldWidget.actu.video != null) {
      if (oldWidget.actu.video!.videoLink != widget.actu.video!.videoLink) {
        _disposeController();
        _initializeVideo();
      }
    }
  }

  Future<void> _initializeVideo() async {
    if (widget.actu.video == null) {
      setState(() {
        _hasError = false;
      });
      return;
    }
    if (_isInitializing || widget.actu.video!.videoLink.isEmpty) return;

    setState(() {
      _isInitializing = true;
      _hasError = false;
      _errorMessage = null;
    });

    try {
      _videoCubit = context.read<VideoCubit>();

      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.actu.video!.videoLink),
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

      // if (mounted) {
      setState(() {
        _isInitializing = false;
      });
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
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: widget.actu.video!.thumbnail.isNotEmpty
          ? Image(
              image: context
                  .read<AppCacheManager>()
                  .getImage(widget.actu.video!.thumbnail),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _buildLoadingIndicator();
              },
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

    return Expanded(
      // width: screenWidth,
      // height: screenWidth / aspectRatio,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8),
      //   color: Colors.black,
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AppVideoPlayer(
          controller: _controller!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Nécessaire pour AutomaticKeepAliveClientMixin
    print('Vidéo: ${widget.actu.video!.videoLink}');
    print('thumbnail: ${widget.actu.video!.thumbnail}');
    return Semantics(
      label: 'Vidéo: ${widget.actu.title ?? "Contenu vidéo"}',
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contenu vidéo
            if (_hasError || widget.actu.video == null)
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
class ActuVideoWidget extends StatelessWidget {
  final Actu actu;
  final VoidCallback? onTap;
  final bool autoPlay;
  final bool showControls;

  const ActuVideoWidget({
    super.key,
    required this.actu,
    this.onTap,
    this.autoPlay = false, // Par défaut false pour économiser la bande passante
    this.showControls = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ActuItemVideo(
        actu: actu,
      ),
    );
  }
}
