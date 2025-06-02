import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/widgets/app_video_player.dart'
    show VideoVolumeCubit;
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/screens/sub/video_fullscreen.dart';
import 'package:beauty/my_pro/screens/sub/video_catalogue_fullscreen.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:video_player/video_player.dart';

class VideoProgressBar extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isFull;
  final bool isActu;
  final Catalogue? catalogue;

  const VideoProgressBar(
      {super.key,
      required this.controller,
      this.isFull = false,
      this.isActu = true,
      this.catalogue});

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(1, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    late final volumeCubit = context.read<VideoVolumeCubit>();

    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final position = value.position;
        final duration = value.duration;

        final current = position.inMilliseconds
            .toDouble()
            .clamp(0.0, duration.inMilliseconds.toDouble());
        final total = duration.inMilliseconds.toDouble();

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(position),
                    style: const TextStyle(color: Colors.white, fontSize: 10)),
                Slider(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  value: current,
                  max: total > 0 ? total : 1,
                  onChanged: (newValue) {
                    controller.seekTo(Duration(milliseconds: newValue.toInt()));
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                ),
                Text(_formatDuration(duration),
                    style: const TextStyle(color: Colors.white, fontSize: 10)),
                IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  onPressed: () {
                    volumeCubit.set(volumeCubit.state == 0.0 ? 1.0 : 0.0);
                    controller.setVolume(volumeCubit.state == 0.0 ? 1.0 : 0.0);
                  },
                  icon: Icon(
                    volumeCubit.state == 0.0
                        ? Icons.volume_off
                        : Icons.volume_up,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  onPressed: () {
                    context.read<VideoCubit>().set(controller);
                    isFull
                        ? Navigator.pop(context)
                        : isActu
                            ? VideoFullScreen.navigate(
                                context: context,
                                actu: context.read<ActuCubit>().actu,
                              )
                            : VideoCatalogueFullScreen.navigate(
                                context: context,
                                catalogue: catalogue!,
                              );
                  },
                  icon: Icon(
                    isFull ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                  ),
                ),
              ],
            ));
      },
    );
  }
}
