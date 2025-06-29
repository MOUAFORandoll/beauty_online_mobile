import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/services/professional_cubit_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/home/widgets/actu_item_video.dart';
import 'package:beauty/professional/bloc/catalogue_cubit.dart';
import 'package:beauty/professional/bloc/catalogue_cubit_manager.dart';
import 'package:beauty/professional/bloc/professional_cubit.dart';
import 'package:beauty/professional/screens/sub/catalogue_for_user_details.dart.dart';
import 'package:beauty/professional/widgets/catalogue_item_photo.dart';
import 'package:beauty/professional/widgets/catalogue_item_video.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:video_player/video_player.dart';

class CatalogueItem extends StatefulWidget {
  final Catalogue catalogue;

  static Widget get({
    required BuildContext context,
    required Catalogue catalogue,
    required Professional professional,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: context.read<CatalogueCubitManager>().get(catalogue)),
        BlocProvider.value(
          value: context.read<ProfessionalCubitManager>().get(professional),
        ),
      ],
      child: CatalogueItem(
        catalogue: catalogue,
      ),
    );
  }

  const CatalogueItem({
    super.key,
    required this.catalogue,
  });

  @override
  State<CatalogueItem> createState() => _CatalogueItemState();
}

class _CatalogueItemState extends State<CatalogueItem> {
  late final catalogueCubit = context.read<CatalogueCubit>();
  VideoPlayerController? _controller;
  late final VideoCubit videoCubit = context.read<VideoCubit>();

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didUpdateWidget(CatalogueItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Réinitialiser si l'URL de la vidéo a changé
    if (oldWidget.catalogue.video != null) {
      if (oldWidget.catalogue.video!.videoLink !=
          widget.catalogue.video!.videoLink) {
        _disposeController();
        _initializeVideo();
      }
    }
  }

  Future<void> _initializeVideo() async {
    if (catalogueCubit.catalogue.video == null) {
      return;
    }
    if (catalogueCubit.catalogue.video!.videoLink.isEmpty) return;

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(catalogueCubit.catalogue.video!.videoLink),
        httpHeaders: {
          'User-Agent': 'Beauty Video Player',
        },
      );

      // Configuration du controller
      await _controller!.initialize();

      // Configuration des options

      await _controller!.setLooping(true);
      await _controller!.setVolume(0.0);

      await _controller!.play();
    } catch (error) {
      debugPrint('Erreur initialisation vidéo: $error');
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
    late final professionalCubit = context.read<ProfessionalCubit>();

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return CatalogueForUserDialog.get(
              context: context,
              catalogue: widget.catalogue,
              professional: professionalCubit.professional);
        },
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.catalogue.isVideo ?? false
              ? widget.catalogue.toVideoPlayer(
                  controller: _controller!,
                )

              // CatalogueItemVideo(
              //     catalogue: catalogue,
              //   )
              : CatalogueItemPhoto(catalogue: widget.catalogue),
        ],
      ),
    );
  }
}
