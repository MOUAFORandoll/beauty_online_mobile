import 'package:beauty/common/utils/photo_full.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:beauty/my_pro/bloc/gestion_professional_cubit.dart';
import 'package:beauty/my_pro/bloc/load_me_catalogue_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/my_pro/widgets/catalogue_photo_component.dart';
import 'package:beauty/my_pro/widgets/catalogue_video_component.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/libs.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CatalogueForProDialog extends StatelessWidget {
  final Catalogue catalogue;
  const CatalogueForProDialog({
    Key? key,
    required this.catalogue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<GestionProfessionalCubit, GestionProfessionalState>(
      listener: (ctx, state) {
        if (state is DeletedCatalogueSuccessState) {
          context.read<LoadMeCatalogueCubit>().reset();
          Navigator.pop(context);
          showSuccessToast(
              context: context, content: 'Produit supprimé avec succès!');
        }
        if (state is GestionProfessionalErrorState) {
          showErrorToast(context: context, content: state.error);
        }
      },
      builder: (ctx, state) => Container(
        width: size.width * 0.95,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Image Carousel
            // ClipRRect(
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(16),
            //     topRight: Radius.circular(16),
            //   ),
            //   child: catalogue.realisationFiles.isNotEmpty
            //       ? CarouselSlider(
            //           options: CarouselOptions(
            //             height: 350,
            //             viewportFraction: 1.0,
            //             enlargeCenterPage: false,
            //             autoPlay: true,
            //             enableInfiniteScroll:
            //                 catalogue.realisationFiles.length > 1,
            //           ),
            //           items: catalogue.realisationFiles.map((file) {
            //             return Builder(
            //               builder: (BuildContext context) {
            //                 return Container(
            //                   width: MediaQuery.of(context).size.width,
            //                   decoration: const BoxDecoration(
            //                     color: Colors.grey,
            //                   ),
            //                   child: Image.network(
            //                     file.filePath,
            //                     fit: BoxFit.cover,
            //                     errorBuilder: (context, error, stackTrace) {
            //                       return const Center(
            //                         child: Icon(
            //                           Icons.image_not_supported,
            //                           color: Colors.white54,
            //                           size: 50,
            //                         ),
            //                       );
            //                     },
            //                     loadingBuilder:
            //                         (context, child, loadingProgress) {
            //                       if (loadingProgress == null) return child;
            //                       return Center(
            //                         child: CircularProgressIndicator(
            //                           value:
            //                               loadingProgress.expectedTotalBytes !=
            //                                       null
            //                                   ? loadingProgress
            //                                           .cumulativeBytesLoaded /
            //                                       loadingProgress
            //                                           .expectedTotalBytes!
            //                                   : null,
            //                         ),
            //                       );
            //                     },
            //                   ).fullScreen(context),
            //                 );
            //               },
            //             );
            //           }).toList(),
            //         )
            //       : Container(
            //           height: 350,
            //           color: Colors.grey[300],
            //           child: const Center(
            //             child: Icon(
            //               Icons.image_not_supported,
            //               color: Colors.white54,
            //               size: 50,
            //             ),
            //           ),
            //         ),
            // ),

            catalogue.isVideo ?? false
                ? CatalogueVideoComponent(catalogue)
                : CataloguePhotoComponent(catalogue),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24)
                  .add(EdgeInsets.symmetric(horizontal: 20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    catalogue.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Price
                  if (catalogue.price != null && catalogue.price!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${catalogue.price} €',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.pink.shade700,
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Image Counter
                  if (catalogue.realisationFiles.length > 1)
                    Text(
                      '${catalogue.realisationFiles.length} images disponibles',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                  const SizedBox(height: 16),

                  state is DeletingCatalogueLoadingState
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : // Reserve Button
                      BeautyButton.primary(
                          onPressed: () {
                            context
                                .read<GestionProfessionalCubit>()
                                .deleteCatalogue(id: catalogue.id);
                          },
                          text: 'SUPPRIMER',
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
