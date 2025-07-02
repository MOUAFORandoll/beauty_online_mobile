import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:beauty/auth/widgets/animated_logo.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/utils/themes.dart';

class AppUpgradeScreen extends StatelessWidget {
  const AppUpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.darkTheme(context),
      child: PopScope(
        canPop: false,
        child: Scaffold(
            appBar: AppBar(automaticallyImplyLeading: false),
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  const AnimatedLogo(),
                  const SizedBox(height: 32.0),
                  Text(
                    "Mise à jour!",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    "Une mise à jour de l'application est maintenant disponible."
                    " Télécharge la pour continuer.",
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 3)
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BeautyButton.white(
                    onPressed: StoreRedirect.redirect,
                    text: "Télécharger",
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
