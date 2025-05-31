import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/my_pro/bloc/gestion_professional_cubit.dart';
import 'package:beauty/my_pro/bloc/load_me_pro_rendez_vous_cubit.dart';
import 'package:beauty/my_pro/screens/sub/rendez_vous_accepted.dart';
import 'package:beauty/my_pro/screens/sub/rendez_vous_refused.dart';
import 'package:beauty/professional/widgets/item_rendez_vous.dart';
import 'package:flutter/material.dart' hide SearchBar, Notification;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:url_launcher/url_launcher.dart';

class MyRendezVousProView extends StatefulWidget {
  final RendezVous rendezVous;
  final bool closeButton;

  const MyRendezVousProView(
      {super.key, required this.rendezVous, this.closeButton = true});

  @override
  State<MyRendezVousProView> createState() => _MyRendezVousProViewState();
}

class _MyRendezVousProViewState extends State<MyRendezVousProView>
    with CompletableMixin {
  late final gestionProfessionalCubit =
      context.read<GestionProfessionalCubit>();
  late final loadMeProRendezVousCubit =
      context.read<LoadMeProRendezVousCubit>();
  @override
  Widget build(BuildContext context) {
    final rdv = widget.rendezVous;
    final user = rdv.user;
    final realisation = rdv.realisation;
    final creneau = rdv.creneau;
    final dateFormat = DateFormat.yMMMMEEEEd().format(rdv.day);
    final time = '${creneau.startTimeAvailable} - ${creneau.endTimeAvailable}';

    return BlocConsumer<GestionProfessionalCubit, GestionProfessionalState>(
        listener: (ctx, state) {
          if (state is AcceptRendezVousLoadingState ||
              state is DeclineRendezVousLoadingState) {
            loadingDialogCompleter = showLoadingBarrier(context: context);
          } else if (state is AcceptRendezVousSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => RendezVousAcceptedPage(
                          rendezVous: rdv,
                        )),
                (r) => false);
            loadMeProRendezVousCubit.reset();
            showSuccessToast(
                context: context, content: 'Rendez-vous accepté avec succès!');
          }
          if (state is DeclineRendezVousSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) =>
                        RendezVousRefusedPage(rendezVous: rdv)),
                (r) => false);
            loadMeProRendezVousCubit.reset();
            showSuccessToast(
                context: context, content: 'Rendez-vous décliné avec succès!');
          }
          if (state is GestionProfessionalErrorState) {
            showErrorToast(context: context, content: state.error);
          }
        },
        builder: (ctx, state) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(spacing: 12, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Détails du rendez-vous',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (widget.closeButton)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close),
                    )
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle(title: 'Client'),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(user.pictureUrl),
                      ),
                      title: Text(user.userName ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(user.phone != null
                          ? '${user.codePhone}  ${user.phone}'
                          : user.email),
                    ),
                    const Divider(height: 32),
                    _SectionTitle(title: 'Service réservé'),
                    const SizedBox(height: 8),
                    Text(realisation.title,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('${realisation.price} €'),
                    const Divider(height: 32),
                    _SectionTitle(title: 'Date & Heure'),
                    const SizedBox(height: 8),
                    Text(dateFormat, style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('Heure : $time'),
                    const Divider(height: 32),
                    _SectionTitle(title: 'Statut'),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(rdv.status.toUpperCase()),
                      backgroundColor: statusColor(rdv.status),
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    if (widget.rendezVous.status == 'EN ATTENTE')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: BeautyButton.secondary(
                              onPressed: () =>
                                  gestionProfessionalCubit.declineRendezVous(
                                      idRendezVous: widget.rendezVous.id),
                              text: "Decliner",
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: BeautyButton.primary(
                              onPressed: () =>
                                  gestionProfessionalCubit.acceptRendezVous(
                                      idRendezVous: widget.rendezVous.id),
                              text: "Accepter",
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ])));
  }

  void _launchMaps(String professionalId) async {
    // Tu peux modifier cette URL si tu stockes l'adresse ou les coordonnées
    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=Cabinet+$professionalId');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d’ouvrir l’itinéraire.')),
      );
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey,
        fontSize: 14,
        letterSpacing: 1.2,
      ),
    );
  }
}
