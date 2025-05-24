import 'dart:developer';

import 'package:beauty/common/bloc/select_realisation_cubit.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/bottom_sheet.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/item_pro.dart';
import 'package:beauty/home/bloc/actu_cubit.dart';
import 'package:beauty/home/models/actu.dart';
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
  int _currentCarouselIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  late final actuCubit = context.read<ActuCubit>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Important pour que l'image commence en haut
      floatingActionButton: _buildFloatingListButtons(),
      body: Stack(
        children: [
          // Image principale qui commence en haut
          SingleChildScrollView(
            child: Column(
              children: [
                // Carousel d'images
                _buildImageCarousel(),
                SizedBox(height: 16),
                // Section d'informations
                _buildInfoSection(),
                SizedBox(height: 16),
              ],
            ),
          ),

          // Boutons flottants
          _buildFloatingButtons(),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    final actu = actuCubit.actu;

    return Stack(
      children: [
        // Carousel d'images
        actu.realisationFiles.isNotEmpty
            ? CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.6,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  enableInfiniteScroll: actu.realisationFiles.length > 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentCarouselIndex = index;
                    });
                  },
                ),
                items: actu.realisationFiles.map((file) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                          child: Image(
                            fit: BoxFit.cover,
                            image: context
                                .read<AppCacheManager>()
                                .getImage(file.filePath),
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.error,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                              size: 32,
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              )
            : Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.white54,
                    size: 50,
                  ),
                ),
              ),

        // Indicateurs de carrousel
        if (actu.realisationFiles.length > 1)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actu.realisationFiles.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(
                        _currentCarouselIndex == entry.key ? 0.9 : 0.4,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoSection() {
    final actu = actuCubit.actu;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
          const SizedBox(height: 16),
          ProfessionalItem.get(
              context: context, professional: actu.profileProfessionnel),
          const SizedBox(height: 16),
          BeautyButton.primary(
            onPressed: () {
              log(actu.profileProfessionnel.toJson().toString());
              context.read<SelectRealisationCubit>().change(actu.id);

              showAppBottomSheet(
                  context: context,
                  maxHeight: MediaQuery.of(context).size.height * .8,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return AgendaProView.get(
                        context: context,
                        professional: actu.profileProfessionnel);
                  });
            },
            text: "Prendre Rendez-vous",
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _circleButton(
              Icons.arrow_back_ios_new,
              onTap: () => Navigator.of(context).pop(),
            ),
            Row(
              children: [
                _circleButton(Icons.more_horiz),
                const SizedBox(width: 8),
                _circleButton(Icons.bookmark, color: Colors.red),
              ],
            ),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _squareButton(
                        title: actu.nombreVues,
                        icon: Icons.remove_red_eye,
                        isLoading: false,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      _squareButton(
                        title: 10,
                        isLoading: false,
                        icon: Icons.favorite,
                        onTap: () => Navigator.of(context).pop(),
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
      Color color = Colors.white,
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
                  color: Colors.white,
                ),
                const SizedBox(width: 2),
                Text(title.toString(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                        )),
              ]),
      ),
    );
  }
}
