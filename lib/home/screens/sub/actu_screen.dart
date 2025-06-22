import 'dart:developer';

import 'package:beauty/common/bloc/select_realisation_cubit.dart';
import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/photo_full.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/app_video_player.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/item_pro.dart';
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/screens/sub/actu_photo_component.dart';
import 'package:beauty/home/screens/sub/actu_video_component.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:beauty/professional/screens/sub/agenda_pro.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/common/widgets/loaders.dart';
import 'package:potatoes/libs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart'; 
class ActuScreen extends StatefulWidget {
  const ActuScreen._();
  static Widget get({required BuildContext context, required Actu actu}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<ActuCubitManager>().get(actu)),
      ],
      child: ActuScreen._(),
    );
  }

  @override
  State<ActuScreen> createState() => _ActuScreenState();
}

class _ActuScreenState extends State<ActuScreen> with CompletableMixin {
  late final actuCubit = context.read<ActuCubit>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final actu = actuCubit.actu;

    return Scaffold(
      extendBodyBehindAppBar:
          true, // Important pour que l'image commence en haut

      body: SafeArea(
        minimum: EdgeInsets.only(
          bottom: 24,
          top: 8,
        ),
        child:
            // Image principale qui commence en haut
            Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      actu.isVideo ?? false
                          ? ActuVideoComponent()
                          : ActuPhotoComponent(),
                      _buildFloatingButtons()
                    ],
                  ),
                ),
                SizedBox(height: 16),
                _buildFloatingListButtons(),
                SizedBox(height: 16), // Section d'informations
                _buildInfoSection(),
                SizedBox(height: 16),
              ],
            ))),
            // Container(
            //   margin: EdgeInsets.only(left: 16, right: 16),
            //   child: BeautyButton.primary(
            //     onPressed: () {
            //       log(actuCubit.actu.profileProfessionnel.toJson().toString());
            //       context
            //           .read<SelectRealisationCubit>()
            //           .change(actuCubit.actu.id);

            //       showAppBottomSheet(
            //           context: context,
            //           maxHeight: MediaQuery.of(context).size.height * .8,
            //           isScrollControlled: true,
            //           builder: (BuildContext context) {
            //             return AgendaProView.get(
            //                 context: context,
            //                 professional: actuCubit.actu.profileProfessionnel);
            //           });
            //     },
            //     text: "Prendre Rendez-vous",
            //   ),
            // ),
          ],
        ),
      ),
      // Boutons flottants
    );
  }

  Widget _buildInfoSection() {
    final actu = actuCubit.actu;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(8, 0, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      actu.title + actu.title ?? '',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${actu.price} €',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ProfessionalItem.get(
              context: context, professional: actu.profileProfessionnel),
        ],
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _circleButton(
              Icons.arrow_back_ios_new,
              onTap: () => Navigator.of(context).pop(),
            ),
            // Row(
            //   children: [
            //     _circleButton(Icons.more_horiz),
            //     const SizedBox(width: 8),
            //     _circleButton(Icons.bookmark, color: Colors.red),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon,
      {Color color = Colors.white, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _buildFloatingListButtons() {
    return BlocProvider.value(
        value: actuCubit,
        child: BlocConsumer<ActuCubit, ActuState>(
            buildWhen: (_, state) => state is ActuLoadedState,
            listener: onEventReceived,
            builder: (context, state) {
              print(state);
              final actu = actuCubit.actu;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _squareButton(
                        title: actu.nombreVues,
                        icon: Icons.remove_red_eye,
                        isLoading: false,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      _squareButton(
                        title: actu.nombreLikes,
                        isLoading: false,
                        color: actu.hasLiked
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        icon: Icons.favorite,
                        onTap: () => actuCubit.likeActu(),
                      ),
                      const SizedBox(width: 8),
                      _squareButton(
                        title: actu.nombrePartages,
                        icon: Icons.share,
                        isLoading: state is ShareActuLoadingState,
                        onTap: () => actuCubit.shareActu(),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  void onEventReceived(BuildContext context, ActuState state) async {
    if (state is ShareActuLoadingState) {
    } else if (state is ShareActuSuccessState) {
      await Share.share(state.shareLink);
    } else if (state is ActuErrorState) {
      showErrorToast(content: state.error, context: context);
    }
  }

  Widget _squareButton(
      {required int title,
      required IconData icon,
      Color? color,
      VoidCallback? onTap,
      required bool isLoading}) {
    print(isLoading);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: isLoading
            ? Container(
                padding: const EdgeInsets.all(2),
                height: 24,
                width: 24,
                child: CircularProgressIndicator())
            : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(
                  icon,
                  size: 24,
                  color: color ?? Colors.white,
                ),
                const SizedBox(width: 2),
                Text(title.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: color ?? Colors.white,
                        )),
              ]),
      ),
    );
  }
}
