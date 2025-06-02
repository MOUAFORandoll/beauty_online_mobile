import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/account/screens/settings/change_picture_screen.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';

class EditProfilePictureScreen extends StatelessWidget {
  const EditProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.fullBlackTheme(context),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Photo de profil'),
            centerTitle: true,
            actions: [
              PopupMenuButton(
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: ImageSource.camera,
                    child: ListTile(
                      leading: Icon(Icons.camera_alt),
                      minLeadingWidth: 24.0,
                      title: Text('Prendre une photo'),
                      titleTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                      dense: true,
                    ),
                  ),
                  PopupMenuItem(
                    value: ImageSource.gallery,
                    child: ListTile(
                      leading: Icon(Icons.image),
                      minLeadingWidth: 24.0,
                      title: Text('Choisir une image'),
                      titleTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                      dense: true,
                    ),
                  ),
                ],
                onSelected: (value) =>
                    onPickImage(source: value, context: context),
                icon: toSvgIcon(
                    icon: Assets.iconsEdit,
                    color: Theme.of(context).appBarTheme.foregroundColor),
              )
            ],
          ),
          body: BlocBuilder<UserCubit, UserState>(
            buildWhen: (_, state) => state is UserLoggedState,
            builder: (_, __) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    fit: BoxFit.cover,
                    image: context
                        .read<AppCacheManager>()
                        .getImage(context.read<UserCubit>().user.pictureUrl),
                    width: double.infinity,
                    errorBuilder: (context, url, error) => Container(
                      height: 368,
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  onPickImage({required ImageSource source, required BuildContext context}) {
    ImagePicker().pickImage(source: source).then((image) {
      if (image == null) return;

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ChangePictureScreen(image: image)),
      );
    });
  }
}
