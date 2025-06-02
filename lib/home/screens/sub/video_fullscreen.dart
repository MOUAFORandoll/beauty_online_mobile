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

class VideoFullScreen extends StatefulWidget {
  const VideoFullScreen._();

  static Future<void> navigate({
    required BuildContext context,
    required Actu actu,
  }) {
    final actuCubit = context.read<ActuCubitManager>().get(actu);

    return Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<ActuCubitManager>().get(actu)),
        ],
        child: VideoFullScreen._(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ZoomPageTransitionsBuilder().buildTransitions(
            PageRouteBuilder(pageBuilder: (_, __, ___) => SizedBox()),
            context,
            animation,
            secondaryAnimation,
            child);
      },
    ));
  }

  @override
  State<VideoFullScreen> createState() => _VideoFullScreenState();
}

class _VideoFullScreenState extends State<VideoFullScreen> {
  late final VideoCubit videoCubit = context.read<VideoCubit>();

  final isCollapsed = ValueNotifier<bool>(true);
  bool showDecoration = true;
  bool showCommentInput = false;

  late final actuCubit = context.read<ActuCubit>();
  bool actionButton = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // videoCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actu = actuCubit.actu;
    return Theme(
      data: AppTheme.fullBlackTheme(context),
      child: Builder(builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: Theme.of(context)
              .appBarTheme
              .systemOverlayStyle!
              .copyWith(statusBarColor: Colors.black38),
          child: SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0,
                leading: Container(),
                actions: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(
                    width: 16,
                  )
                ],
              ),
              body: ValueListenableBuilder(
                valueListenable: videoCubit.state!,
                builder: (context, value, _) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(alignment: Alignment.bottomCenter, children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          setState(() => actionButton = !actionButton);
                          Future.delayed(Duration(seconds: 2), () {
                            setState(() => actionButton = false);
                          });
                        },
                        child: ClipRRect(
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
                                  height: MediaQuery.of(context).size.width *
                                      (1 / value.size.aspectRatio),
                                  width: MediaQuery.of(context).size.width,
                                  child: AppVideoPlayer(
                                    controller: videoCubit.state!,
                                    autoPlay: true,
                                    looping: true,
                                  ),
                                )),
                        ),
                      ),
                      Positioned(
                          bottom: 2,
                          child: VideoProgressBar(
                            controller: videoCubit.state!,
                            isFull: true,
                          )),
                    ]),
                    if (actionButton)
                      Container(
                        height: MediaQuery.of(context).size.height,
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
                              value.isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
