import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart';
import 'package:beauty/account/screens/settings/edit_profile_picture_screen.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/utils/validators.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:beauty/utils/dialogs.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with CompletableMixin {
  late final userCubit = context.read<UserCubit>();
  late final TextEditingController userNameController =
      TextEditingController(text: userCubit.user.userName);
  late final TextEditingController userBioController =
      TextEditingController(text: userCubit.user.phone);
  final formKey = GlobalKey<FormState>();
  // final TextEditingController phoneController = TextEditingController();
  // PhoneNumber _phoneNumber =
  //     PhoneNumber(countryCode: 'CA', countryISOCode: 'CA', number: '');

  @override
  void dispose() {
    userNameController.dispose();
    userBioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: onEventReceived,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Éditer mon profil",
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.only(bottom: 48),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).add(
                const EdgeInsets.only(top: 16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfilePictureScreen())),
                          child: ProfilePicture(
                            image: userCubit.user.pictureUrl,
                            size: 56,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "@${userCubit.user.userName}"),
                              readOnly: true,
                            ),
                          ),
                        )
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: [
                        TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          controller: userNameController,
                          decoration: const InputDecoration(
                            helperText:
                                "Il sera visible lors de tes différentes intéractions",
                            hintText: "Nom d'utilisateur",
                          ),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: FocusScope.of(context).unfocus,
                          validator: (value) => Validators.empty(value),
                        ),
                        const SizedBox(height: 32),
                        TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          controller: userBioController,
                          decoration: const InputDecoration(
                            hintText: "Ma bio…",
                          ),
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.newline,
                          minLines: 4,
                          maxLines: 4,
                          maxLength: 180,
                          maxLengthEnforcement:
                              MaxLengthEnforcement.truncateAfterCompositionEnds,
                          onEditingComplete: FocusScope.of(context).unfocus,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BeautyButton.primary(
                onPressed: onSaveTap,
                text: "Enregistrer",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSaveTap() {
    if (formKey.currentState?.validate() ?? false) {
      userCubit.updateUser(
          username: userNameController.text.trim(),
          biography: userBioController.text.trim());
    }
  }

  void onEventReceived(BuildContext context, UserState state) async {
    await waitForDialog();

    if (state is UserUpdatingState) {
      loadingDialogCompleter = showLoadingBarrier(context: context);
    } else if (state is UserUpdatedState) {
      userCubit.refreshData();
      Navigator.of(context).pop();
    } else if (state is UserErrorState) {
      showErrorToast(content: state.error, context: context);
    }
  }
}
