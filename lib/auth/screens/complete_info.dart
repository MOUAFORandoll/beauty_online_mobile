import 'package:beauty/common/screens/home.dart';
import 'package:beauty/common/widgets/c_input_phone.dart';
import 'package:flutter/services.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart';
import 'package:beauty/auth/bloc/auth_cubit.dart';
import 'package:beauty/common/utils/validators.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:beauty/utils/dialogs.dart';

import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

class CompleteInfoPage extends StatefulWidget {
  const CompleteInfoPage({super.key});

  @override
  State<CompleteInfoPage> createState() => _CompleteInfoPageState();
}

class _CompleteInfoPageState extends State<CompleteInfoPage>
    with CompletableMixin {
  late final authCubit = context.read<AuthCubit>();
  final userTagNode = FocusNode();

  @override
  void dispose() {
    userTagNode.dispose();
    super.dispose();
  }

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  PhoneNumber _phoneNumber =
      PhoneNumber(countryCode: 'CA', countryISOCode: 'CA', number: '');

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: onEventReceived,
        buildWhen: (_, state) => state is AuthIdleState,
        builder: (context, state) {
          var authIdleState = (state as AuthIdleState);
          return Scaffold(
            appBar: AppBar(
                title: const Text(
              "Tu viens d'arriver ??",
            )),
            body: SafeArea(
              minimum: const EdgeInsets.only(bottom: 48),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              style: Theme.of(context).textTheme.bodyMedium,
                              controller: userNameController,
                              decoration: const InputDecoration(
                                helperText:
                                    "Il sera visible lors de tes différentes intéractions",
                                hintText: "Ton nom d'utilisateur",
                              ),
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(userTagNode),
                              validator: (value) => Validators.empty(value),
                            ),
                            const SizedBox(height: 10),
                            Text('Entrez votre numéro de téléphone'),
                            const SizedBox(height: 2),
                            CustomIntlPhoneField(
                              controller: phoneController,
                              initialCountryCode: 'CM',
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              minimum:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BeautyButton.primary(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authCubit.completeUserName(
                          userName: userNameController.text,
                          phone: _phoneNumber.number,
                          countryCode: _phoneNumber.countryCode,
                        );
                      }
                    },
                    text: "Continuer",
                  ),
                ],
              ),
            ),
          );
        });
  }

  void onEventReceived(BuildContext context, AuthState state) async {
    await waitForDialog();

    if (state is AuthLoadingState) {
      loadingDialogCompleter = showLoadingBarrier(context: context);
    } else if (state is CompletedUserSuccessUserState) {
      
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (r) => false);
    } else if (state is AuthErrorState) {
      showErrorToast(content: state.error, context: context);
    }
  }
}
