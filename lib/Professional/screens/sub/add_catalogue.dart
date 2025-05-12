import 'dart:io';
import 'package:beauty/Professional/bloc/gestion_professional_cubit.dart';
import 'package:beauty/Professional/bloc/load_me_catalogue_cubit.dart';
import 'package:beauty/common/utils/dialogs.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/common/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:potatoes_secured_preferences/potatoes_secured_preferences.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1200,
      );

      if (pickedFiles.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(pickedFiles.map((e) => File(e.path)).toList());
        });
      }
    } catch (e) {
      // Handle exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la sélection des images: $e')),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un prix';
    }

    // Remove currency symbol and spaces if present
    String cleanValue = value.replaceAll(RegExp(r'[^\d.,]'), '');
    // Replace comma with dot for parsing
    cleanValue = cleanValue.replaceAll(',', '.');

    try {
      double price = double.parse(cleanValue);
      if (price <= 0) {
        return 'Le prix doit être supérieur à 0';
      }
    } catch (e) {
      return 'Veuillez entrer un prix valide';
    }

    return null;
  }

  late final _gestionProfessionalCubit =
      context.read<GestionProfessionalCubit>();
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedImages.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez ajouter au moins une image')),
        );
        return;
      }
      _gestionProfessionalCubit.addCatalogue(
          libelle: _titleController.text,
          prix: _priceController.text,
          images: _selectedImages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GestionProfessionalCubit, GestionProfessionalState>(
      listener: (ctx, state) {
        if (state is AddCatalogueSuccessState) {
          if (mounted) {
            context.read<LoadMeCatalogueCubit>().reset();
            showSuccessToast(
                context: context, content: 'Produit ajouté avec succès!');
            setState(() {
              _priceController.clear();
              _selectedImages.clear();
            });
          }
        }
        if (state is GestionProfessionalErrorState) {
          if (mounted) {
            showErrorToast(context: context, content: state.error);
          }
        }
      },
      builder: (ctx, state) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Ajouter un produit',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Images Section
                  _buildImagesSection(),
                  const SizedBox(height: 24),

                  // Title Field
                  _buildTextField(
                    controller: _titleController,
                    label: 'Titre',
                    hint: 'Entrez le titre du produit',
                    icon: Icons.title,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un titre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Price Field
                  _buildTextField(
                    controller: _priceController,
                    label: 'Prix',
                    hint: '0.00 €',
                    icon: Icons.euro,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: _validatePrice,
                    // onEditingComplete: () {
                    //   if (_priceController.text.isNotEmpty) {
                    //     // Format the price as currency
                    //     try {
                    //       String cleanValue = _priceController.text
                    //           .replaceAll(RegExp(r'[^\d.,]'), '');
                    //       cleanValue = cleanValue.replaceAll(',', '.');
                    //       double price = double.parse(cleanValue);

                    //       final formatter = NumberFormat.currency(
                    //           locale: 'fr_FR', symbol: '€');
                    //       final formattedPrice = formatter.format(price);

                    //       // Update the text field without triggering onChanged again
                    //       if (formattedPrice != _priceController.text) {
                    //         _priceController.value = TextEditingValue(
                    //           text: formattedPrice,
                    //           selection: TextSelection.collapsed(
                    //               offset: formattedPrice.length),
                    //         );
                    //       }
                    //     } catch (_) {
                    //       // If parsing fails, leave the input as is
                    //     }
                    //   }
                    // },
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: BeautyButton.primary(
                      icon: (state is AddCatalogueLoadingState)
                          ? Container(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: AppTheme.primaryRed,
                              ),
                            )
                          : null,
                      onPressed: _submitForm,
                      text: 'AJOUTER AU CATALOGUE',
                    ),
                  ),
                  // Submit Button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Photos du produit',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _selectedImages.isEmpty
              ? InkWell(
                  onTap: _pickImages,
                  borderRadius: BorderRadius.circular(12),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ajouter des photos',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  children: [
                    // Add photo button
                    InkWell(
                      onTap: _pickImages,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            width: 2,
                            // style: BorderStyle.dashed,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              size: 32,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Ajouter',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Selected images
                    ..._selectedImages.asMap().entries.map((entry) {
                      final index = entry.key;
                      final image = entry.value;
                      return Stack(
                        children: [
                          Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: FileImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 16,
                            child: GestureDetector(
                              onTap: () => _removeImage(index),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
        ),
        if (_selectedImages.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '${_selectedImages.length} photo${_selectedImages.length > 1 ? 's' : ''} sélectionnée${_selectedImages.length > 1 ? 's' : ''}',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? onEditingComplete,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            prefixIconColor: Theme.of(context).colorScheme.primary,
          ),
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
        ),
      ],
    );
  }
}
