import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/screens/sub/actu_screen.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

class ActuItemBottomInfo extends StatefulWidget {
  
  @override
  State<ActuItemBottomInfo> createState() => _ActuItemBottomInfoState();
}

class _ActuItemBottomInfoState extends State<ActuItemBottomInfo> {
  late final actuCubit = context.read<ActuCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActuCubit, ActuState>(
        buildWhen: (_, state) => state is ActuLoadedState,
        builder: (context, state) {
          final actu = actuCubit.actu;
          return Container(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfilePicture(
                    image: actu.profileProfessionnel.cover, size: 24),
                buildInfo(title: actu.nombreVues, icon: Icons.remove_red_eye),
                buildInfo(
                    title: actu.nombreLikes,
                    icon: Icons.favorite,
                    color: actu.hasLiked
                        ? Theme.of(context).colorScheme.primary
                        : null),
                buildInfo(title: actu.nombrePartages, icon: Icons.share)
              ],
            ),
          );
        });
  }

  Widget buildInfo(
          {required int title, required IconData icon, Color? color}) =>
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(
          icon,
          size: 16,
          color: color ?? Colors.white,
        ),
        const SizedBox(width: 2),
        Text(title.toString(),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                )),
      ]);
}
