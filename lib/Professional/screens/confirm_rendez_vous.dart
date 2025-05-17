import 'dart:math';

import 'package:beauty/common/models/agenda.dart';
import 'package:beauty/common/screens/home.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/professional/bloc/action_professional_cubit.dart';
import 'package:beauty/professional/bloc/load_me_rendez_vous_cubit.dart';
import 'package:beauty/professional/bloc/professional_cubit.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/professional/screens/sub/primary_info_pro_client.dart';
import 'package:beauty/professional/screens/sub/stories.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/services/professional_cubit_manager.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';

import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';

import '../../professional/screens/sub/catalogue_pro.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmationRendezVousScreen extends StatelessWidget {
  final Agenda agenda;
  final Creneau creneau;
  final Professional professional;
  const ConfirmationRendezVousScreen({
    super.key,
    required this.agenda,
    required this.creneau,
    required this.professional,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMMEEEEd('fr_FR').format(agenda.day);

    late final actionProfessionalCubit =
        context.read<ActionProfessionalCubit>();
    return BlocConsumer<ActionProfessionalCubit, ActionProfessionalState>(
      listener: (context, state) {
        if (state is NewRendezVousSuccessState) {
          context.read<LoadMeRendezVousCubit>().reset();
          showSuccessToast(
              context: context,
              content: 'Nouvelle réservation effectuée avec succès!');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (r) => false);
        }
        if (state is ActionProfessionalErrorState) {
          showErrorToast(content: state.error, context: context);
        }
      },
      builder: (ctx, state) => Scaffold(
        appBar: AppBar(title: const Text("Confirmer la réservation")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfessionalCard(context),
              const SizedBox(height: 30),
              _buildInfoTile(Icons.calendar_today, "Date", formattedDate),
              _buildInfoTile(Icons.access_time, "Créneau horaire",
                  '${creneau.startTimeAvailable} - ${creneau.endTimeAvailable}'),
              const Spacer(),
              state is NewRendezVousLoadingState
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : BeautyButton.primary(
                      onPressed: () {
                        actionProfessionalCubit.newRendezVous(
                          creneauId: creneau.id,
                        );
                      },
                      text: "Confirmer la réservation",
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfessionalCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: professional.cover != null
                  ? NetworkImage(professional.cover!)
                  : null,
              child: professional.cover == null
                  ? const Icon(Icons.person, size: 32)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    professional.namePro,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    professional.service ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            "$label : ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
