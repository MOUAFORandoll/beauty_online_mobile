import 'package:beauty/common/widgets/c_input_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart';
import 'package:beauty/account/screens/settings/edit_profile_picture_screen.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/utils/validators.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:beauty/common/utils/dialogs.dart';

class EditProfileScreen extends StatefulWidget {
  final int type;
  const EditProfileScreen({super.key, required this.type});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with CompletableMixin {
  late final userCubit = context.read<UserCubit>();
  late final TextEditingController controller = TextEditingController(text: '');
  late PhoneNumber _phoneNumber;

  @override
  void initState() {
    super.initState();

    if (widget.type == 0) controller.text = userCubit.user.userName!;
    if (widget.type == 1) controller.text = userCubit.user.phone!;
    if (widget.type == 1)
      _phoneNumber = PhoneNumber(
          countryCode: userCubit.user.countryCode!,
          countryISOCode: userCubit.user.countryCode!,
          number: userCubit.user.phone!);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
        listener: onEventReceived,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Handle cancel action
                  },
                  child: const Text(
                    'Annuler',
                    style: TextStyle(
                      color: Colors.grey,
                      // color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),

                // Title
                Text(
                  widget.type == 0 ? 'Nom' : 'Numéro',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Save button
                TextButton(
                  onPressed: onSaveTap,
                  child: const Text(
                    'Enregistrer',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                if (widget.type == 0)
                  // Name input field
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Votre ${widget.type == 0 ? 'nom' : 'numéro'}',
                    ),
                  ),
                if (widget.type == 1)
                  CustomIntlPhoneField(
                    controller: controller,
                    initialValue: _phoneNumber,
                    initialCountryCode: _phoneNumber.countryCode,
                    countries: countries,
                    hintText: 'Entrez votre numéro de téléphone',
                    onChanged: (phone) {
                      _phoneNumber = phone;
                    },
                    onSaved: (phone) {
                      _phoneNumber = phone!;
                    },
                    invalidNumberMessage: 'Invalide',
                    validator: (phone) {
                      if (phone == null || phone.number.isEmpty) {
                        return 'Invalide';
                      }
                      if (!phone.isValidNumber()) {
                        return 'Invalide';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 12),
                Text(
                  'Ce ${widget.type == 0 ? 'nom' : 'numéro'} sera visible par les personnes avec qui vous interagissez, si ces dernières ne vous ont pas enregistré·e comme contact.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void onSaveTap() {
    // if (formKey.currentState?.validate() ?? false) {
    userCubit.updateUser(
      data: controller.text.trim(),
      type: widget.type,
      countryCode: widget.type == 1 ? _phoneNumber.countryISOCode : null,
      codePhone: widget.type == 1 ? _phoneNumber.countryCode : null,
    );
    // }
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
