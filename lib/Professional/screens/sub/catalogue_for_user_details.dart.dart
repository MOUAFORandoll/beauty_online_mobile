import 'package:beauty/professional/bloc/load_pro_catalogue_cubit.dart';
import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/professional/widgets/item_catalogue.dart';
import 'package:beauty/common/models/service_model.dart';
import 'package:beauty/common/widgets/empty_builder.dart';
import 'package:beauty/common/widgets/error_builder.dart';
import 'package:beauty/common/widgets/loader_builder.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:beauty/common/widgets/service_item.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:potatoes/auto_content/widgets/auto_content_view.dart';
import 'package:potatoes/auto_list.dart';
import 'package:potatoes/libs.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CatalogueForUserDialog extends StatelessWidget {
  final Catalogue catalogue; 

  const CatalogueForUserDialog({
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

    return Container(
      width: size.width * 0.85,
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: catalogue.realisationFiles.isNotEmpty
                ? CarouselSlider(
                    options: CarouselOptions(
                      height: 350,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      autoPlay: true,
                      enableInfiniteScroll:
                          catalogue.realisationFiles.length > 1,
                    ),
                    items: catalogue.realisationFiles.map((file) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Image.network(
                              file.filePath,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.white54,
                                    size: 50,
                                  ),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }).toList(),
                  )
                : Container(
                    height: 350,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                        size: 50,
                      ),
                    ),
                  ),
          ),

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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

                // Reserve Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade400,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'RÉSERVER',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
