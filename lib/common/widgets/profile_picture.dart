import 'package:beauty/common/utils/photo_full.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';

class ProfilePicture extends StatelessWidget {
  final String? image;
  final double size;

  const ProfilePicture({
    super.key,
    required this.image,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    final defaultImage =
        toSvgIcon(icon: Assets.defaultAvatar, defaultFilter: false, size: size);
    if (image == null) return defaultImage;
    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          shape: BoxShape.circle),
      child: Image(
        fit: BoxFit.cover,
        image: context.read<AppCacheManager>().getImage(image!),
        errorBuilder: (context, url, error) => defaultImage,
      ).fullScreen(context),
    );
  }
}

class ProfileSquarePicture extends StatelessWidget {
  final String? image;
  final double size;

  const ProfileSquarePicture({
    super.key,
    required this.image,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    final defaultImage =
        toSvgIcon(icon: Assets.defaultAvatar, defaultFilter: false, size: size);
    if (image == null) return defaultImage;
    return Container(
      height: size,
      width: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(8)),
      child: Image(
        fit: BoxFit.cover,
        image: context.read<AppCacheManager>().getImage(image!),
        errorBuilder: (context, url, error) => defaultImage,
      ).fullScreen(context),
    );
  }
}

class UserProfilePicture extends StatelessWidget {
  final double size;
  final bool isSquare;
  const UserProfilePicture(
      {super.key, this.size = 40.0, this.isSquare = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (_, state) => state is UserLoggedState,
      builder: (_, state) => isSquare
          ? ProfileSquarePicture(
              image: context.read<UserCubit>().user.pictureUrl,
              size: size,
            )
          : ProfilePicture(
              image: context.read<UserCubit>().user.pictureUrl,
              size: size,
            ),
    );
  }
}
