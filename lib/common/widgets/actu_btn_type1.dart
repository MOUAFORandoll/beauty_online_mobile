// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:potatoes/libs.dart'; 
// import 'package:umai/utils/assets.dart';
// import 'package:umai/utils/svg_utils.dart'; 
// import 'package:potatoes/common/widgets/loaders.dart'; 
// import 'package:umai/common/bloc/common_cubit.dart'; 
// import 'package:umai/common/screens/common_details.dart'; 
// import 'package:umai/utils/dialogs.dart';
// import 'package:share_plus/share_plus.dart';

// class ActuBtnType1Widget<T extends XItem> extends StatefulWidget {
//   const ActuBtnType1Widget({
//     required this.onPressed,
//     super.key,
//   });
//   final VoidCallback onPressed;

//   @override
//   State<ActuBtnType1Widget<T>> createState() => _ActuBtnType1WidgetState<T>();
// }

// class _ActuBtnType1WidgetState<T extends XItem>
//     extends State<ActuBtnType1Widget<T>> with CompletableMixin {
//   late final commonCubit = context.read<XCommonCubit<T>>();

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<XCommonCubit<T>, AXCommonState>(
//       listener: onEventReceived,
//       buildWhen: (_, state) => state is XCommonState,
//       builder: (context, state) {
//         final item = commonCubit.x;
//         return Row(
//           children: [
//             IconButton(
//               padding: EdgeInsets.zero,
//               icon: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (item.itemLikesCount > 0 && !(item.itemLikesCount == 1 && item.itemHasLiked))
//                     ...[
//                       Transform.translate(
//                         offset: const Offset(0, 1.5),
//                         child: Text(
//                           NumberFormat.compact().format(item.itemLikesCount),
//                           style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                             color: item.itemHasLiked
//                               ? Theme.of(context).colorScheme.tertiary
//                               : Theme.of(context).colorScheme.onSurfaceVariant,
//                             fontSize: 18
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 2.0),
//                     ],
//                   toSvgIcon(
//                     icon: Assets.iconsLike,
//                     color: item.itemHasLiked
//                       ? Theme.of(context).colorScheme.tertiary
//                       : Theme.of(context).colorScheme.onSurfaceVariant,
//                     size: 16.0
//                   )
//                 ],
//               ),
//               onPressed: () {
//                 item.itemHasLiked
//                   ? commonCubit.unLikeItem()
//                   : commonCubit.likeItem();
//               },
//             ),
//             IconButton(
//               padding: EdgeInsets.zero,
//               icon: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   if (item.itemCommentsCount > 0)
//                     ...[
//                       Transform.translate(
//                         offset: const Offset(0, 1.5),
//                         child: Text(
//                           NumberFormat.compact().format(item.itemCommentsCount),
//                           style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                             color: Theme.of(context).colorScheme.onSurfaceVariant,
//                             fontSize: 18
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 2.0),
//                     ],
//                   toSvgIcon(
//                     icon: Assets.iconsComment,
//                     color: Theme.of(context).colorScheme.onSurfaceVariant,
//                     size: 16.0
//                   ),
//                 ],
//               ),
//               onPressed: widget.onPressed,
//             ),
//             const Spacer(),
//             IconButton(
//               padding: EdgeInsets.zero,
//               icon: toSvgIcon(
//                 icon: Assets.iconsShare,
//                 color: Theme.of(context).colorScheme.onSurfaceVariant,
//                 size: 16.0
//               ),
//               onPressed: () => commonCubit.shareItem(),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void onEventReceived(BuildContext context, AXCommonState state) async {
//     await waitForDialog();

//     if (state is ShareItemLoadingState) {
//       loadingDialogCompleter = showLoadingBarrier(
//         context: context,
//       );
//     } else if (state is ShareItemSuccessState) {
//       await Share.share(state.shareLink);
//     } else if (state is XErrorState) {
//       showErrorToast(content: state.error, context: context);
//     }
//   }
// }
