import 'package:beauty/common/bloc/home_bottom_navigation_cubit.dart';
import 'package:beauty/common/screens/home.dart';
import 'package:beauty/common/utils/text_utils.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:beauty/common/models/rendez_vous.dart';
import 'package:potatoes/libs.dart';

class RendezVousAcceptedPage extends StatelessWidget {
  final RendezVous rendezVous;

  const RendezVousAcceptedPage({super.key, required this.rendezVous});

  @override
  Widget build(BuildContext context) {
    final date =
        DateFormat.yMMMMEEEEd('fr_FR').format(rendezVous.day).capitalize();
    final time =
        '${rendezVous.creneau.startTimeAvailable} - ${rendezVous.creneau.endTimeAvailable}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rendez-vous confirmé'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary, size: 100),
              const SizedBox(height: 24),
              Text(
                'Vous avez confirmé le rendez-vous!',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text('Date : $date', style: const TextStyle(fontSize: 16)),
              Text('Heure : $time', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 32),
              BeautyButton.primary(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (r) => false);
                  context.read<HomeBottomNavigationCubit>().goToPage(index: 0);
                },
                text: "Retourner à l’accueil",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
