import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/photo_full.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/screens/sub/actu_screen.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:beauty/home/widgets/actu_item_photo.dart';
import 'package:beauty/home/widgets/actu_item_video.dart';
import 'package:beauty/home/widgets/item_actu_bottom_info.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:video_player/video_player.dart';

class ActuItem extends StatefulWidget {
  final Actu actu;
  const ActuItem({
    super.key,
    required this.actu,
  });

  static Widget get({required BuildContext context, required Actu actu}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<ActuCubitManager>().get(actu)),
      ],
      child: ActuItem(actu: actu),
    );
  }

  @override
  State<ActuItem> createState() => _ActuItemState();
}

class _ActuItemState extends State<ActuItem>
    with AutomaticKeepAliveClientMixin {
  late final actuCubit = context.read<ActuCubit>();
  VideoPlayerController? _controller;
  late final VideoCubit videoCubit = context.read<VideoCubit>();

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
  void didUpdateWidget(ActuItem oldWidget) {
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
    if (actuCubit.actu.video == null) {
      setState(() {
        _hasError = false;
      });
      return;
    }
    if (_isInitializing || actuCubit.actu.video!.videoLink.isEmpty) return;

    setState(() {
      _isInitializing = true;
      _hasError = false;
      _errorMessage = null;
    });

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(actuCubit.actu.video!.videoLink),
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

  @override
  Widget build(BuildContext context) {
    final actu = actuCubit.actu;

    return GestureDetector(
      onTap: () {
        actuCubit.vueActu();
        videoCubit.set(_controller);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ActuScreen.get(actu: actu, context: context)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            actu.isVideo ?? false
                ? ActuItemVideo(actu: actu, controller: _controller!)
                : ActuItemPhoto(actu: actu),

            // Gradient fondu en bas
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 100,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.black87,
                      Colors.black54,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Infos bas (titre + autres infos)
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    actu.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        const Shadow(
                          color: Colors.black,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                        const Shadow(
                          color: Colors.black87,
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  ActuItemBottomInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
