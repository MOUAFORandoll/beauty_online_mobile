import 'package:beauty/common/models/professional.dart';
import 'package:beauty/common/models/rendez_vous.dart';
import 'package:beauty/common/services/geolocation_service.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/map/map_tracking_screen.dart';
import 'package:beauty/professional/widgets/item_rendez_vous.dart';
import 'package:flutter/material.dart' hide SearchBar, Notification;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:potatoes/libs.dart';
import 'package:url_launcher/url_launcher.dart';

class RendezVousUserView extends StatefulWidget {
  final RendezVous rendezVous;
  final bool closeButton;
  const RendezVousUserView(
      {super.key, required this.rendezVous, this.closeButton = true});

  @override
  State<RendezVousUserView> createState() => _RendezVousUserViewState();
}

class _RendezVousUserViewState extends State<RendezVousUserView> {
  @override
  Widget build(BuildContext context) {
    final rdv = widget.rendezVous;
    final user = rdv.user;
    final realisation = rdv.realisation;
    final professional = rdv.professional;
    final creneau = rdv.creneau;
    final dateFormat = DateFormat.yMMMMEEEEd().format(rdv.day);
    final time = '${creneau.startTimeAvailable} - ${creneau.endTimeAvailable}';

    return Padding(
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
                _SectionTitle(title: 'Profesionnel'),
                const SizedBox(height: 8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(professional.cover ?? ''),
                  ),
                  title: Text(professional.namePro,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(rdv.professionalPhone ?? ''),
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
                  label: Text(rdv.status),
                  backgroundColor: statusColor(rdv.status),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                if (widget.rendezVous.status == 'ACCEPTE')
                  BeautyButton.primary(
                    icon: const Icon(Icons.call),
                    text: 'Contacter le professionnel',
                    onPressed: () {
                      // Implémenter l'appel
                      launchUrl(Uri.parse("tel:${rdv.professionalPhone}"));
                    },
                  ),
                if (widget.rendezVous.status == 'ACCEPTE')
                  SizedBox(
                    width: double.infinity,
                    child: BeautyButton.secondary(
                        icon: const Icon(Icons.navigation),
                        text: 'Suivre l’itinéraire',
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapTrackingScreen(
                                  professional: professional,
                                ),
                              ),
                            )
                        //  _launchMaps(rdv.professional),
                        ),
                  )
              ],
            ),
          ),
        ]));
  }

  void _launchMaps(Professional professional) async {
    // Tu peux modifier cette URL si tu stockes l'adresse ou les coordonnées

    // print(isLoad);
    // setState(() {
    //   isLoad = true;
    // });

    await context
        .read<GeolocationService>()
        .getCurrentPosition()
        .then((currentPosition) async {
      if (currentPosition != null) {
        final url = Uri.parse(
            'https://www.google.com/maps/dir/?api=1&origin=${currentPosition.latitude},${currentPosition.longitude}&destination=${professional.position!.latitude},${professional.position!.longitude}');
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Impossible d’ouvrir l’itinéraire.')),
          );
        } // setState(() {
        //   isLoad = false;
        // });
      }
    });
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
