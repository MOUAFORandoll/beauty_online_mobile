import 'dart:io';

import 'package:beauty/auth/screens/complete_info.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:potatoes/potatoes.dart';
import 'package:beauty/auth/bloc/auth_cubit.dart';
import 'package:beauty/auth/widgets/animated_logo.dart';
import 'package:beauty/auth/widgets/auth_button.dart';
import 'package:beauty/common/screens/home.dart';
import 'package:beauty/common/services/api_service.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with CompletableMixin {
  late final authCubit = context.read<AuthCubit>();
  bool animationEnded = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: onEventReceived,
      child: Scaffold(
        body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                // Arrière-plan SVG plein écran
                Positioned.fill(
                  child: Image.asset(
                    Assets.onBoardingImage2,

                    fit: BoxFit.cover,
                    // colorFilter: const ColorFilter.mode(
                    //   Colors.white,
                    //   BlendMode.srcIn,
                    // ),
                  ),
                ),

                // Contenu au-dessus
                Center(
                  child: SafeArea(
                    minimum: const EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      bottom: 48.0,
                    ),
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        AnimatedLogo(
                          onEnd: () => setState(() => animationEnded = true),
                        ),
                        const Spacer(flex: 3),
                        if (animationEnded) ...[
                          if (Platform.isIOS)
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: 1),
                              curve: Curves.easeIn,
                              duration: const Duration(milliseconds: 300),
                              builder: (context, opacity, child) => Opacity(
                                opacity: opacity,
                                child: child,
                              ),
                              child: AuthButton.apple(
                                onPressed: () =>
                                    acceptTerm(then: authCubit.appleSignIn),
                                backgroundColor: AppTheme.white,
                                textColor: AppTheme.primaryBlack,
                              ),
                            ),
                          const SizedBox(height: 16.0),
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 1),
                            curve: Curves.easeIn,
                            duration: const Duration(milliseconds: 300),
                            builder: (context, opacity, child) => Opacity(
                              opacity: opacity,
                              child: child,
                            ),
                            child: AuthButton.google(
                              onPressed: () =>
                                  acceptTerm(then: authCubit.googleSignIn),
                              backgroundColor: AppTheme.primaryBlack,
                              textColor: AppTheme.white,
                            ),
                          ),
                        ] else
                          SizedBox(
                              height: (40.0 + 16.0) * (Platform.isIOS ? 2 : 1)),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void acceptTerm({required VoidCallback then}) => showAppBottomSheet(
      context: context,
      builder: (_) => Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Connexion & inscription',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16.0),
              Text.rich(TextSpan(
                children: [
                  const TextSpan(
                      text:
                          'En cliquant sur Continuer, tu confirmes avoir pris connaissance et accepté notre '),
                  TextSpan(
                      text: 'politique de confidentialité',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrlString(ApiLinks.privacy,
                              mode: LaunchMode.inAppBrowserView);
                        },
                      style: const TextStyle(
                          decoration: TextDecoration.underline)),
                  const TextSpan(text: '.'),
                ],
                style: Theme.of(context).textTheme.bodyMedium,
              )),
              const SizedBox(height: 64.0),
              BeautyButton.primary(
                onPressed: then,
                text: "Continuer",
              ),
            ],
          )));

  void onEventReceived(BuildContext context, AuthState state) async {
    await waitForDialog();

    if (state is AuthLoadingState) {
      loadingDialogCompleter = showLoadingBarrier(context: context);
    } else if (state is CompletedUserSuccessUserState) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (r) => false);
    } else if (state is NoCompletedUserState) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const CompleteInfoPage()),
          (r) => false);
    } else if (state is AuthErrorState) {
      showErrorToast(content: state.error, context: context);
    }
  }
}
