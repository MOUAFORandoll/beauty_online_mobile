import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/my_pro/screens/sub/catalogue_for_pro_details.dart.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/my_pro/widgets/my_item_catalogue_photo.dart';
import 'package:beauty/my_pro/widgets/my_item_catalogue_video.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:video_player/video_player.dart';

class MyCatalogueItem extends StatefulWidget {
  final Catalogue catalogue;

  const MyCatalogueItem(this.catalogue, {super.key});

  @override
  State<MyCatalogueItem> createState() => _MyCatalogueItemState();
}

class _MyCatalogueItemState extends State<MyCatalogueItem>
    with AutomaticKeepAliveClientMixin {
  VideoPlayerController? _controller;
  late final VideoCubit videoCubit = context.read<VideoCubit>();

  bool _isInitializing = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didUpdateWidget(MyCatalogueItem oldWidget) {
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
    if (widget.catalogue.video == null) {
      setState(() {});
      return;
    }
    if (_isInitializing || widget.catalogue.video!.videoLink.isEmpty) return;

    setState(() {
      _isInitializing = true;
    });

    try {
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
        });
      }
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
    super.build(context);
    return GestureDetector(
      onTap: () {
        videoCubit.set(_controller);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CatalogueForProDialog(
              catalogue: widget.catalogue,
            );
          },
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.catalogue.isVideo ?? false
              ? MyItemCatalogueVideo(widget.catalogue)
              : MyItemCataloguePhoto(widget.catalogue),
          if (widget.catalogue.isVideo ?? false)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    toSvgIcon(
                        icon: Assets.iconPlay,
                        size: 32.0,
                        color: AppTheme.white),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${widget.catalogue.price} €',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppTheme.white),
                    )
                  ],
                )),
              ),
            ),
        ],
      ),
    );
  }
}
