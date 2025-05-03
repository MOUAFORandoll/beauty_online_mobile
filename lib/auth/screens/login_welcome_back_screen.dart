import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:beauty/auth/bloc/auth_cubit.dart';
import 'package:beauty/common/screens/home.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/utils/themes.dart';

@Deprecated("Not used anymore")
class LoginWelcomeBackScreen extends StatefulWidget {
  const LoginWelcomeBackScreen({super.key});

  @override
  State<LoginWelcomeBackScreen> createState() => _LoginWelcomeBackScreenState();
}

class _LoginWelcomeBackScreenState extends State<LoginWelcomeBackScreen> {
  late final authCubit = context.read<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.primaryColorTheme(context),
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.only(bottom: 32.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text('Bon retour parmi nous!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall),
                  ),
                ),
                BeautyButton.white(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false);
                  },
                  text: "Merci",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
