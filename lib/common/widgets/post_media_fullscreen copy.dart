// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:potatoes/libs.dart';
// import 'package:umai/common/bloc/action_comment_cubit.dart';
// import 'package:umai/common/bloc/common_cubit.dart';
// import 'package:umai/common/bloc/report_cubit.dart';
// import 'package:umai/common/services/cache_manager.dart';
// import 'package:umai/common/widgets/app_video_player.dart';
// import 'package:umai/common/widgets/button_common.dart';
// import 'package:umai/common/widgets/comment_input.dart';
// import 'package:umai/common/widgets/item_user.dart';
// import 'package:umai/common/widgets/read_more_theme.dart';
// import 'package:umai/social/bloc/post_cubit.dart';
// import 'package:umai/social/bloc/video_cubit.dart';
// import 'package:umai/social/models/post.dart';
// import 'package:umai/social/services/post_cubit_manager.dart';
// import 'package:umai/utils/themes.dart';

// class PostMediaFullScreen extends StatefulWidget {
//   final void Function(BuildContext context, XReportState state) onReportEventReceived;

//   const PostMediaFullScreen._({required this.onReportEventReceived});

//   static Future<void> navigate({
//     required BuildContext context,
//     required Post post,
//     onReportEventReceived,
//   }) {
//     final postCubit = context.read<PostCubitManager>().get(post);
    
//     return Navigator.of(context).push(PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => MultiBlocProvider(
//         providers: [
//           BlocProvider.value(value: postCubit),
//           BlocProvider.value(value: postCubit as XCommonCubit<Post>),
//           BlocProvider<ActionCommentBaseCubit<XCommonCubit<Post>>>(
//             create: (context) => ActionCommentCubit(postCubit)),
//         ],
//         child: PostMediaFullScreen._(
//           onReportEventReceived: onReportEventReceived,
//         ),
//       ),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return ZoomPageTransitionsBuilder().buildTransitions(
//           PageRouteBuilder(pageBuilder: (_, __, ___) => SizedBox()),
//           context,
//           animation,
//           secondaryAnimation,
//           child
//         );
//       },
//     ));
//   }

//   @override
//   State<PostMediaFullScreen> createState() => _PostMediaFullScreenState();
// }

// class _PostMediaFullScreenState extends State<PostMediaFullScreen> {
//   late final postCubit = context.read<PostCubit>();
//   late final VideoCubit videoCubit;
//   final isCollapsed = ValueNotifier<bool>(true);
//   bool showDecoration = true;
//   bool showCommentInput = false;

//   @override
//   void initState() {
//     super.initState();
//     videoCubit = context.read<VideoCubit>();
//   }

//   @override
//   void dispose() {
//     videoCubit.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: AppTheme.fullBlackTheme(context),
//       child: Builder(builder: (context) {
//         return AnnotatedRegion<SystemUiOverlayStyle>(
//           value: Theme.of(context).appBarTheme.systemOverlayStyle!.copyWith(
//             statusBarColor: Colors.black38
//           ),
//           child: SafeArea(
//             child: Scaffold(
//               extendBodyBehindAppBar: true,
//               resizeToAvoidBottomInset: false,
//               body: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   _FullScreenMedia(key: ValueKey('fullscreen-media')),
//                   GestureDetector(
//                     onTap: () => setState(() => showDecoration = !showDecoration),
//                     child: AnimatedOpacity(
//                       opacity: showDecoration ? 1.0 : 0.0,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.fastOutSlowIn,
//                       child: Scaffold(
//                         primary: false,
//                         appBar: AppBar(
//                           backgroundColor: Colors.black38,
//                           actions: [
//                             // TODO
//                           ],
//                         ),
//                         backgroundColor: Colors.transparent,
//                         bottomNavigationBar: ColoredBox(
//                           color: Theme.of(context)
//                               .scaffoldBackgroundColor
//                               .withOpacity(0.6),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                 child: UserItem.get(
//                                   context: context,
//                                   user: postCubit.x.user
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                 child: AnimatedSize(
//                                   duration: const Duration(milliseconds: 300),
//                                   alignment: Alignment.bottomLeft,
//                                   curve: Curves.easeInOut,
//                                   child: ThemedReadMoreText(
//                                     postCubit.x.content,
//                                     trimLines: 2,
//                                     isCollapsed: isCollapsed,
//                                     style: Theme.of(context).textTheme.bodySmall,
//                                   ),
//                                 ),
//                               ),
//                               ButtonCommon<Post>(
//                                 onCommentTap: () => setState(() {
//                                   showCommentInput = true;
//                                 }),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   if (showCommentInput)
//                     GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         setState(() {
//                           WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
//                           showCommentInput = false;
//                         });
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//                         child: Scaffold(
//                           primary: false,
//                           backgroundColor: Colors.transparent,
//                           bottomNavigationBar: CommentInput<Post>(autofocus: true),
//                         ),
//                       ),
//                     )
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// class _FullScreenMedia extends StatelessWidget {
//   const _FullScreenMedia({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final videoCubit = context.read<VideoCubit>();
//     final post = context.read<PostCubit>().x;

//     if (post.video != null) {
//       return ValueListenableBuilder(
//         valueListenable: videoCubit.state!,
//         builder: (context, value, _) {
//           if (!value.isInitialized) {
//             return Image(
//               image: context.read<AppCacheManager>().getImage(post.video!.thumbnailUrl),
//               fit: BoxFit.cover,
//               width: double.infinity,
//             );
//           } else {
//             return Center(
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.width * (1 / value.size.aspectRatio),
//                 width: MediaQuery.of(context).size.width,
//                 child: AppVideoPlayer(
//                   controller: videoCubit.state!,
//                   autoPlay: true,
//                   looping: true
//                 ),
//               ),
//             );
//           }
//         },
//       );
//     } else if (post.image != null) {
//       return PhotoView(
//         minScale: PhotoViewComputedScale.contained,
//         maxScale: PhotoViewComputedScale.covered,
//         imageProvider: context.read<AppCacheManager>().getImage(post.image!),
//       );
//     } else {
//       return const SizedBox();
//     }
//   }
// }
