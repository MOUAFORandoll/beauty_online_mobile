import 'package:flutter/material.dart';

abstract class Validators {
  static const emailPattern =
      r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
  static const datePattern =
      r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[1,3-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$|(?:(?:1[6-9]|[2-9]\d)?\d{2})(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\5(?:0?[1-9]|1\d|2[0-8])$|^(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\/|-|\.)0?2\6(29)$|^(?:(?:1[6-9]|[2-9]\d)?\d{2})(?:(?:(\/|-|\.)(?:0?[1,3-9]|1[0-2])\8(?:29|30))|(?:(\/|-|\.)(?:0?[13578]|1[02])\9(?:31)))$';
  static const passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}$';
  static const String numbersOnlyPattern = r'([0-9])';
  static const String numbersAndPlusOnlyPattern = r'(\+|[0-9])';

  static String? empty(String? value) {
    if (value?.isEmpty ?? false) {
      return "Ce champ est obligatoire";
    }
    return null;
  }

  static String? email(String? value) {
    if (value?.isEmpty ?? false) {
      return empty(value);
    } else if (!RegExp(emailPattern).hasMatch(value!)) {
      return "Adresse mail invalide";
    }
    return null;
  }

  static String? mobile(String? value) {
    if (value?.isEmpty ?? false) {
      return empty(value);
    }
    return null;
  }

  static String? password(String? value) {
    if (value?.isEmpty ?? false) {
      return empty(value);
    } else if (value!.length < 8) {
      return "Mot de passe trop court";
    } else if (!RegExp(passwordPattern).hasMatch(value)) {
      return "Au moins une majuscule, une minuscule et un chiffre";
    }
    return null;
  }

  static String? passwordConfirmation(String? value, String? toConfirm) {
    final String? firstCheck = password(value);

    if (firstCheck != null) return firstCheck;
    if (value == toConfirm) return null;
    return "Le mot de passe n'est pas identique";
  }

  static bool isCursorImmediatelyAfterAtSymbol(
      TextEditingController controller) {
    final int cursorPosition = controller.selection.extentOffset;

    final String currentText = controller.text;

    if (currentText.isNotEmpty) {
      // L'index du caractère juste AVANT le curseur est cursorPosition - 1
      final int charIndexBeforeCursor = cursorPosition - 1;

      return currentText[charIndexBeforeCursor] == '@';
    }

    // Si le curseur est à la position 0 ou si le texte est vide,
    // il n'y a pas de caractère '@' juste avant.
    return false;
  }

  static bool isCursorImmediatelyAfterAtSymbolAndNothingAfter(
      TextEditingController controller) {
    final int cursorPosition = controller.selection.extentOffset;
    final String currentText = controller.text;

    if (currentText.isNotEmpty) {
      final int lastAtSymbolIndex = currentText.lastIndexOf('@');

      // Vérifier si un '@' existe dans le texte
      if (lastAtSymbolIndex != -1) {
        // Vérifier si le curseur est positionné juste après le dernier '@'
        if (cursorPosition == lastAtSymbolIndex + 1) {
          // Vérifier si le curseur est à la fin du texte (rien après '@')
          return cursorPosition == currentText.length;
        }
      }
    } else {
      return true;
    }

    return false;
  }
}
