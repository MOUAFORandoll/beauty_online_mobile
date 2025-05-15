import 'package:beauty/common/widgets/c_input_phone.dart';
import 'package:beauty/my_pro/bloc/my_professional_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart';

import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/utils/validators.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:beauty/common/utils/dialogs.dart';

class EditProScreen extends StatefulWidget {
  final int type;
  const EditProScreen({super.key, required this.type});

  @override
  State<EditProScreen> createState() => _EditProScreenState();
}

class _EditProScreenState extends State<EditProScreen> with CompletableMixin {
  late final professionalCubit = context.read<MyProfessionalCubit>();

  late final TextEditingController controller = TextEditingController(text: '');
  late PhoneNumber _phoneNumber;

  @override
  void initState() {
    super.initState();

    if (widget.type == 0)
      controller.text = professionalCubit.professional.namePro!;
    if (widget.type == 1)
      controller.text = professionalCubit.professional.description!;
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyProfessionalCubit, MyProfessionalState>(
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
                  widget.type == 0 ? 'Nom Pro' : 'Description',
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
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText:
                            "Décrivez votre activité \n Ex: Salon spécialisé en coiffure afro...",
                      ),
                      maxLines: 3,
                    ),
                  ),
                const SizedBox(height: 12),
                Text(
                  'Cette informations sera visible par les personnes avec qui vous interagissez, si ces dernières ne vous ont pas enregistré·e comme contact.',
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
    professionalCubit.updateProfilePro(
      data: controller.text.trim(),
      type: widget.type,
    );
    // }
  }

  void onEventReceived(BuildContext context, MyProfessionalState state) async {
    await waitForDialog();

    if (state is MyProfessionalUpdatingState) {
      loadingDialogCompleter = showLoadingBarrier(context: context);
    } else if (state is MyProfessionalUpdatedState) {
      Navigator.of(context).pop();
    } else if (state is UpdateMyProfessionalErrorState) {
      showErrorToast(content: state.error, context: context);
    }
  }
}
