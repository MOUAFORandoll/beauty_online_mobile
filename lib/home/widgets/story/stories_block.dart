// import 'package:flutter/material.dart';
// import 'package:potatoes/auto_list/widgets/auto_list_view.dart';
// import 'package:potatoes/libs.dart'; 

// class StoriesBlock extends StatefulWidget {
//   const StoriesBlock({super.key});

//   @override
//   State<StoriesBlock> createState() => _StoriesBlockState();
// }

// class _StoriesBlockState extends State<StoriesBlock> {
//   late final loadStoryCubit = context.read<HomeActivitiesService>().loadStoryCubit;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: loadStoryCubit,
//       child: SizedBox(
//         height: 96,
//         child: AutoListView.get<Episode>(
//           padding: EdgeInsets.symmetric(horizontal: 8),
//           physics: ClampingScrollPhysics(),
//           autoManage: false,
//           scrollDirection: Axis.horizontal,
//           cubit: loadStoryCubit,
//           itemBuilder: (context, story) =>
//               ItemStory.get(context: context, story: story),
//           separatorBuilder: (_, __) => const SizedBox(width: 8.0),
//           emptyBuilder: (ctx) => const EmptyBuilder(),
//           errorBuilder: (context, retry) => const SizedBox(),
//           loadingBuilder: (_) => const StoriesLoaderBuilder(),
//           loadingMoreBuilder: (_) => const SocialLoaderBuilder(),
//         ),
//       ));
//   }
// }
