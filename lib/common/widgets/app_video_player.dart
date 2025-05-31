import 'package:flutter/material.dart';
import 'package:potatoes/common/bloc/value_cubit.dart';
import 'package:potatoes/libs.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final bool autoManage;
  final bool autoPlay;
  final bool looping;

  const AppVideoPlayer({
    super.key,
    required this.controller,
    this.autoManage = false,
    this.autoPlay = false,
    this.looping = false,
  });

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late final VideoPlayerController controller = widget.controller;
  late final volumeCubit = context.read<VideoVolumeCubit>();

  @override
  void initState() {
    super.initState();
    Future.sync(() {
      if (!controller.value.isInitialized) {
        return controller.initialize();
      }
    }).then((_) {
      controller.setVolume(volumeCubit.state);
      if (widget.autoPlay) {
        controller.play();
      }
      controller.setLooping(widget.looping);
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(controller);
  }

  @override
  void dispose() {
    if (widget.autoManage) {
      controller.dispose();
    }
    super.dispose();
  }
}

class VideoVolumeCubit extends ValueCubit<double> {
  VideoVolumeCubit() : super(1.0);
}