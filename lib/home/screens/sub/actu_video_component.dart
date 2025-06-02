import 'dart:developer';

import 'package:beauty/common/bloc/select_realisation_cubit.dart';
import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/photo_full.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/app_video_player.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/item_pro.dart';
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:beauty/home/widgets/video_progress_bar.dart';
import 'package:beauty/professional/screens/sub/agenda_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class ActuVideoComponent extends StatefulWidget {
  @override
  State<ActuVideoComponent> createState() => _ActuVideoComponentState();
}

class _ActuVideoComponentState extends State<ActuVideoComponent>
    with CompletableMixin {
  late final actuCubit = context.read<ActuCubit>();
  bool actionButton = false;
  late final VideoCubit videoCubit = context.read<VideoCubit>();

  @override
  void dispose() {
    videoCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actu = actuCubit.actu;

    return actu.video != null &&
            actu.video!.videoLink != null &&
            actu.video!.videoLink!.isNotEmpty
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() => actionButton = !actionButton);
              Future.delayed(Duration(seconds: 2), () {
                setState(() => actionButton = false);
              });
            },
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                child: ValueListenableBuilder(
                  valueListenable: videoCubit.state!,
                  builder: (context, value, _) => Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(alignment: Alignment.bottomCenter, children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(32)),
                          child: (!value.isInitialized)
                              ? Image(
                                  image: context
                                      .read<AppCacheManager>()
                                      .getImage(actu.video!.thumbnail),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : Center(
                                  child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: MediaQuery.of(context).size.width,
                                  child: AppVideoPlayer(
                                    controller: videoCubit.state!,
                                    autoPlay: true,
                                    looping: true,
                                  ),
                                )),
                        ),
                        VideoProgressBar(controller: videoCubit.state!),
                      ]),
                      if (actionButton)
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)),
                            color: Colors.black.withOpacity(0.3),
                          ),
                          child: Center(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if (videoCubit.state!.value.isPlaying) {
                                  videoCubit.state!.pause();
                                } else {
                                  videoCubit.state!.play();
                                }
                              },
                              child: Icon(
                                value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 48,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )))
        : Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.image_not_supported,
                color: Colors.white54,
                size: 50,
              ),
            ),
          );
  }
}
