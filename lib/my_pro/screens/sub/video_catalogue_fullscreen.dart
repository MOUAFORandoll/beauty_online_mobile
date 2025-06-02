
import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/app_video_player.dart';
import 'package:beauty/home/widgets/video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potatoes/libs.dart'; 

class VideoCatalogueFullScreen extends StatefulWidget {
  final Catalogue catalogue;

  const VideoCatalogueFullScreen._(this.catalogue);

  static Future<void> navigate(
      {required BuildContext context, required Catalogue catalogue}) {
    return Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          VideoCatalogueFullScreen._(catalogue),
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
  State<VideoCatalogueFullScreen> createState() =>
      _VideoCatalogueFullScreenState();
}

class _VideoCatalogueFullScreenState extends State<VideoCatalogueFullScreen> {
  late final VideoCubit videoCubit = context.read<VideoCubit>();

  final isCollapsed = ValueNotifier<bool>(true);
  bool showDecoration = true;
  bool showCommentInput = false;

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
                                      .getImage(
                                          widget.catalogue.video!.thumbnail),
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
