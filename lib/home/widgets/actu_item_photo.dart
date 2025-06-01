import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/photo_full.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/screens/sub/actu_screen.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:beauty/home/widgets/item_actu_bottom_info.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';

class ActuItemPhoto extends StatefulWidget {
  final Actu actu;

  const ActuItemPhoto({
    super.key,
    required this.actu,
  });

  @override
  State<ActuItemPhoto> createState() => _ActuItemPhotoState();
}

class _ActuItemPhotoState extends State<ActuItemPhoto> {
  late final actuCubit = context.read<ActuCubit>();

  @override
  Widget build(BuildContext context) {
    final actu = actuCubit.actu;

    return Image(
      image: context.read<AppCacheManager>().getImage(
          actu.realisationFiles.isEmpty
              ? 'null'
              : actu.realisationFiles.first.filePath),
      fit: BoxFit.cover,
      width: double.infinity,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame != null) return child;
        return Container(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          child: wasSynchronouslyLoaded
              ? child
              : const Center(
                  child: SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                ),
        );
      },
      errorBuilder: (_, __, ___) => const Icon(Icons.error),
    );
  }
}
