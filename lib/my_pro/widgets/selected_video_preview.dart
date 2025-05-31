import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/widgets/app_video_player.dart';
import 'package:video_player/video_player.dart';

class SelectedVideoPreview extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;

  const SelectedVideoPreview({
    super.key,
    required this.file,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Theme.of(context).colorScheme.tertiaryContainer),
      height: VideoPlayerController.file(file).value.size.height,
      // width: 150,
      child: AppVideoPlayer(
        controller: VideoPlayerController.file(file),
        autoManage: true,
        autoPlay: false,
      ),
    );
  }
}
