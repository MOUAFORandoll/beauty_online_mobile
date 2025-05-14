import 'dart:io';
import 'dart:math';

import 'package:beauty/my_pro/bloc/new_professional_cubit.dart';
import 'package:beauty/my_pro/bloc/my_professional_cubit.dart';
import 'package:beauty/my_pro/screens/sub/catalogue.dart';
import 'package:beauty/my_pro/screens/sub/stories.dart';
import 'package:beauty/account/widgets/btn_account.dart';
import 'package:beauty/account/widgets/primary_info.dart';
import 'package:beauty/common/screens/home.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/services/geolocation_service.dart';
import 'package:beauty/common/utils/validators.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:beauty/common/widgets/read_more_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nested_scroll_view_plus/nested_scroll_view_plus.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:beauty/account/screens/settings/edit_profile.dart';
import 'package:beauty/account/screens/settings/edit_profile_picture_screen.dart';
import 'package:beauty/account/screens/settings/settings_screen.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/widgets/action_widget.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/profile_picture.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/svg_utils.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/utils/loadPicture.dart';

class CreateProfilProScreen extends StatefulWidget {
  const CreateProfilProScreen({super.key});

  @override
  State<CreateProfilProScreen> createState() => _CreateProfilProScreenState();
}

class _CreateProfilProScreenState extends State<CreateProfilProScreen> {
  int _currentStep = 0;

  // Étape 1 - infos pro
  final _nameController = TextEditingController();
  String? _selectedService;
  final _descriptionController = TextEditingController();
  final _formInfoKey = GlobalKey<FormState>();
// ignore: empty_constructor_bodies

  // Étape 2 - localisation
  int? isLoadingPosition;

  double? latitude;
  double? longitude;
  String? country;
  String? town;
  final _emplacementController = TextEditingController();

  final _formLocationKey = GlobalKey<FormState>();

  // Étape 3 - accept conditions
  bool condition = false;
  // Simuler l'envoi
  bool isLoading = false;

  final _services = ["COIFFURE", "MANICURE"];
  XFile? _image;

  Future<void> _pickImage() async {
    final image = await pickImage(context);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewProfessionalCubit, NewProfessionalState>(
      listener: (context, state) {
        if (state is NewProfessionalUploadedState) {
          Navigator.of(context).popUntil((r) => r.isFirst);
        }
        if (state is NewProfessionalErrorState) {
          showErrorToast(content: state.error, context: context);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text("Créer votre profil pro"),
          centerTitle: true,
        ),
        body: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepContinue: _onContinue,
          onStepCancel: _onCancel,
          controlsBuilder: (context, details) {
            return Container(
                margin: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      child: BeautyButton.primary(
                        icon: (state is NewProfessionalUploadedState)
                            ? Container(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: AppTheme.primaryRed,
                                ),
                              )
                            : null,
                        onPressed: details.onStepContinue,
                        text: _currentStep == 2 ? 'Valider' : 'Suivant',
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    if (_currentStep > 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('Retour'),
                      ),
                  ],
                ));
          },
          steps: [
            Step(
              title: const Text("Informations professionnelles"),
              isActive: _currentStep >= 0,
              content: Form(
                key: _formInfoKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: "Nom professionnel",
                      ),
                      validator: (value) => Validators.empty(value),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      validator: (value) => Validators.empty(value),
                      value: _selectedService,
                      items: _services
                          .map(
                              (s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedService = value);
                      },
                      decoration: const InputDecoration(
                        hintText: "Type de service",
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10), // Arrondi circulaire
                            child: _image == null
                                ? toSvgIcon(
                                    icon: Assets.iconsCamera,
                                    size:
                                        MediaQuery.of(context).size.width * .23,
                                  )
                                : Image.file(
                                    File(_image!.path),
                                    height:
                                        MediaQuery.of(context).size.width * .23,
                                    width:
                                        MediaQuery.of(context).size.width * .23,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              hintText:
                                  "Décrivez votre activité \n Ex: Salon spécialisé en coiffure afro...",
                            ),
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Step(
              title: const Text("Localisation"),
              isActive: _currentStep >= 1,
              content: Form(
                key: _formLocationKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Comment appelle tón votre emplacement de service"),
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: (value) => Validators.empty(value),
                      controller: _emplacementController,
                      decoration: const InputDecoration(
                        hintText:
                            "Emplacement, ex : boulevard du 20 mai de paris",
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _getLocation,
                          icon: (isLoadingPosition == 0)
                              ? Container(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: AppTheme.primaryRed,
                                  ),
                                )
                              : (isLoadingPosition == 1)
                                  ? const Icon(Icons.check)
                                  : const Icon(Icons.location_on),
                          label: const Text("Détecter ma position"),
                        ),
                        if (isLoadingPosition == 1)
                          Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            width: 150,
                            child: Text(
                              "📍Lat: $latitude, Long: $longitude",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Step(
              title: const Text("Essai gratuit"),
              isActive: _currentStep >= 2,
              content: state is NewProfessionalUploadingState
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        const Text(
                          "En souscrivant, vous profitez d’un essai gratuit de 30 jours pour tester notre plateforme.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        CheckboxListTile(
                          value: condition,
                          onChanged: (_) {
                            setState(() {
                              condition = !condition;
                            });
                          },
                          title: const Text(
                              "J'accepte les conditions d’utilisation"),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _onContinue() {
    if (_currentStep == 0) {
      if (_formInfoKey.currentState!.validate() && _selectedService != null) {
        setState(() => _currentStep++);
        _getLocation();
      }
    }
    if (_currentStep == 1) {
      if (_formLocationKey.currentState!.validate() && isLoadingPosition == 1) {
        setState(() => _currentStep++);
      }
    }
    if (_currentStep == 2) {
      if (condition) {
        context.read<NewProfessionalCubit>().create(
            namePro: _nameController.text,
            service: _selectedService!,
            description: _descriptionController.text,
            longitude: longitude!,
            latitude: latitude!,
            titleEmplacement: _emplacementController.text,
            image: _image);
      } else {
        // showErrorToast(
        //     content: 'Veuillez accepter les conditions', context: context);
      }
    }
  }

  void _onCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Future<void> _getLocation() async {
    setState(() {
      isLoadingPosition = 0;
    });
    await context
        .read<GeolocationService>()
        .getCurrentPosition()
        .then((Position? position) {
      setState(() {
        latitude = position!.latitude;
        longitude = position!.longitude;
        isLoadingPosition = 1;
      });
    }).onError((e, d) {
      print(e);
      setState(() {
        isLoadingPosition = 2;
      });
    });
  }

  Future<void> _submitProfile() async {
    setState(() => isLoading = true);

    await Future.delayed(
        const Duration(seconds: 2)); // Simule une requête réseau

    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Profil créé avec succès 🎉"),
    ));
    Navigator.pop(context);
  }
}
