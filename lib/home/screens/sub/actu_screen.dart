import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/common/widgets/item_pro.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PinterestViewScreen extends StatefulWidget {
  final Actu actu;

  const PinterestViewScreen(this.actu, {Key? key}) : super(key: key);

  @override
  State<PinterestViewScreen> createState() => _PinterestViewScreenState();
}

class _PinterestViewScreenState extends State<PinterestViewScreen> {
  int _currentCarouselIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Important pour que l'image commence en haut
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
    return Stack(
      children: [
        // Carousel d'images
        widget.actu.realisationFiles.isNotEmpty
            ? CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.6,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  enableInfiniteScroll: widget.actu.realisationFiles.length > 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentCarouselIndex = index;
                    });
                  },
                ),
                items: widget.actu.realisationFiles.map((file) {
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
        if (widget.actu.realisationFiles.length > 1)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  widget.actu.realisationFiles.asMap().entries.map((entry) {
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
                      widget.actu.title + widget.actu.title ?? '',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${widget.actu.price} €',
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
              context: context, professional: widget.actu.profileProfessionnel),
          const SizedBox(height: 16),
          BeautyButton.primary(
            onPressed: () {},
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
}
