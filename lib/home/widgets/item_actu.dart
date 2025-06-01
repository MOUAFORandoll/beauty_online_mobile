import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/photo_full.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/screens/sub/actu_screen.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:beauty/home/widgets/actu_item_photo.dart';
import 'package:beauty/home/widgets/actu_item_video.dart';
import 'package:beauty/home/widgets/item_actu_bottom_info.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

class ActuItem extends StatefulWidget {
  const ActuItem({super.key});

  static Widget get({required BuildContext context, required Actu actu}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<ActuCubitManager>().get(actu)),
      ],
      child: const ActuItem(),
    );
  }

  @override
  State<ActuItem> createState() => _ActuItemState();
}

class _ActuItemState extends State<ActuItem> {
  late final actuCubit = context.read<ActuCubit>();

  @override
  Widget build(BuildContext context) {
    final actu = actuCubit.actu;

    return GestureDetector(
      onTap: () {
        actuCubit.vueActu();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ActuScreen.get(actu: actu, context: context)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            actu.isVideo ?? false
                ? ActuItemVideo(
                    actu: actu,
                  )
                : ActuItemPhoto(actu: actu),

            // Gradient fondu en bas
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 100,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.black87,
                      Colors.black54,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Infos bas (titre + autres infos)
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    actu.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        const Shadow(
                          color: Colors.black,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                        const Shadow(
                          color: Colors.black87,
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  ActuItemBottomInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
