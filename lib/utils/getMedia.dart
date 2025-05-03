import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:photo_manager/photo_manager.dart';

getMediadata() async {
  FilePickerResult?
      media; // Déclarez media en dehors du try-catch si vous en utilisez un
  AssetType? assetType;
  File? file;
  try {
    media = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'webp',
        'bmp',
        'mp4',
        'mov',
        'avi',
        'mkv',
        'webm'
      ],
    );
    if (media != null) {
      final String extension =
          media.files.first.path!.split('.').last.toLowerCase();
      const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'];
      const videoExtensions = ['mp4', 'mov', 'avi', 'mkv', 'webm'];

      if (imageExtensions.contains(extension)) {
        assetType = AssetType.image;
      } else if (videoExtensions.contains(extension)) {
        assetType = AssetType.video;
      }

      file = File(media.files.first.path!);

      // Vous pouvez maintenant utiliser 'file' et 'fileType'
      print('Fichier sélectionné: ${file?.path}');
      print('Type identifié: $assetType');
    } else {
      print('erreur ');
    }
  } catch (e) {
    // Gérer les erreurs potentielles de l'image_picker lui-même
    print('Une erreur est survenue lors de la sélection du média: $e');
    // Optionnel: Réinitialiser l'état
    // setState(() {
    //   file = null;
    //   assetType = null;
    // });
  }

  return [assetType, file];
}
