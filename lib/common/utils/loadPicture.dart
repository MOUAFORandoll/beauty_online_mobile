import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:potatoes/libs.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

Future<XFile?> pickImage(BuildContext context) async {
  return showModalBottomSheet<XFile>(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Container(
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt,
                      size: 40, color: Colors.indigo),
                  onPressed: () async {
                    Navigator.pop(context, await _pickFromCamera(context));
                  },
                ),
                const SizedBox(height: 10),
                const Text('Caméra'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_library,
                      size: 40, color: Colors.indigo),
                  onPressed: () async {
                    Navigator.pop(context, await _pickFromGallery());
                  },
                ),
                const SizedBox(height: 10),
                const Text('Galerie'),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<XFile?> _pickFromCamera(BuildContext context) async {
  final status = await permission.Permission.camera.request();
  if (status.isGranted) {
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 500,
      maxHeight: 500,
    );
    return photo;
  } else {
    _showPermissionDeniedDialog(context, 'Camera');
    return null;
  }
}

Future<XFile?> _pickFromGallery() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 50,
    maxWidth: 1004,
    maxHeight: 638,
  );
  return image;
}

void _showPermissionDeniedDialog(BuildContext context, String permissionName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Permission Denied'),
        content:
            Text('Please grant $permissionName permission in app settings.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
