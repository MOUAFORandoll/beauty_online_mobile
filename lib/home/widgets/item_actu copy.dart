// import 'package:beauty/common/services/cache_manager.dart';
// import 'package:beauty/common/utils/assets.dart';
// import 'package:beauty/common/utils/svg_utils.dart';
// import 'package:beauty/common/utils/themes.dart';
// import 'package:beauty/home/bloc/actu_cubit.dart';
// import 'package:beauty/home/models/actu.dart';
// import 'package:beauty/home/screens/sub/actu_screen.dart';
// import 'package:beauty/home/services/actu_cubit_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:potatoes/libs.dart';

// class ActuItem extends StatefulWidget {
//   const ActuItem({super.key});

//   static Widget get({required BuildContext context, required Actu actu}) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider.value(value: context.read<ActuCubitManager>().get(actu)),
//       ],
//       child: const ActuItem(),
//     );
//   }

//   @override
//   State<ActuItem> createState() => _ActuItemState();
// }

// class _ActuItemState extends State<ActuItem> {
//   late final actuCubit = context.read<ActuCubit>();

//   @override
//   Widget build(BuildContext context) {
//     final actu = actuCubit.actu;

//     return GestureDetector(
//       onTap: () => showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ActuScreen(
//             actu,
//           );
//         },
//       ),
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           actuItemImage(actu: actu, context: context),
//           // Positioned.fill(
//           //   child: Container(
//           //     color: Colors.black.withOpacity(0.2),
//           //     child: Center(
//           //         child: Column(
//           //       mainAxisAlignment: MainAxisAlignment.center,
//           //       crossAxisAlignment: CrossAxisAlignment.center,
//           //       children: [
//           //         toSvgIcon(
//           //             icon: Assets.iconsBookmark,
//           //             size: 32.0,
//           //             color: AppTheme.white),
//           //         SizedBox(
//           //           height: 8,
//           //         ),
//           //         Text(
//           //           '${actu.price} €',
//           //           style: Theme.of(context)
//           //               .textTheme
//           //               .labelLarge!
//           //               .copyWith(color: AppTheme.white),
//           //         )
//           //       ],
//           //     )),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//     // });
//   }

//   actuItemImage({required BuildContext context, required Actu actu}) =>
//       ClipRRect(
//         borderRadius: BorderRadius.circular(16),
//         child: Image(
//           image: context
//               .read<AppCacheManager>()
//               .getImage(actu.realisationFiles.first.filePath),
//           fit: BoxFit.cover,
//           width: double.infinity,
//           frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
//             if (frame != null) return child;
//             return Container(
//               color: Theme.of(context).colorScheme.tertiaryContainer,
//               width: double.infinity,
//               child: wasSynchronouslyLoaded
//                   ? child
//                   : Center(
//                       child: SizedBox(
//                         height: 16.0,
//                         width: 16.0,
//                         child: CircularProgressIndicator(
//                           color:
//                               Theme.of(context).colorScheme.onTertiaryContainer,
//                           strokeWidth: 2.0,
//                         ),
//                       ),
//                     ),
//             );
//           },
//           errorBuilder: (_, __, ___) => const Icon(Icons.error),
//         ),
//       );
// }
