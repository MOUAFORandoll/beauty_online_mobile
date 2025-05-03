import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomIntlPhoneField extends StatelessWidget {
  const CustomIntlPhoneField(
      {super.key,
      this.controller,
      this.initialValue,
      required this.initialCountryCode,
      required this.countries,
      required this.hintText,
      this.onChanged,
      this.onSaved,
      this.validator,
      required this.invalidNumberMessage});
  final TextEditingController? controller;
  final PhoneNumber? initialValue;
  final String initialCountryCode;
  final List<Country> countries;
  final String hintText;
  final String invalidNumberMessage;
  final ValueChanged<PhoneNumber>? onChanged;
  final FormFieldSetter<PhoneNumber>? onSaved;
  final FormFieldValidator<PhoneNumber>? validator;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialCountryCode: countries.isEmpty ? 'CA' : initialCountryCode,
      controller: controller,
      invalidNumberMessage: invalidNumberMessage,
      initialValue: initialValue?.number,
      // decoration: InputDecoration(
      //   hintText: hintText,
      //   counterText: '',
      //   contentPadding: const EdgeInsets.all(15),
      //   filled: true,
      //   fillColor: Colors.white,
      //   border: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.white, width: 0.5),
      //   ),
      //   enabledBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.grey, width: 0.5),
      //   ),
      //   focusedBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.blue, width: 0.5),
      //   ),
      //   errorBorder: const OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.red, width: 1.0),
      //   ),
      // ),
      countries: countries,
      flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 8),
      pickerDialogStyle: PickerDialogStyle(
        backgroundColor: Colors.white,
        countryNameStyle: const TextStyle(fontSize: 14, color: Colors.black),
        countryCodeStyle: const TextStyle(fontSize: 14, color: Colors.black),
      ),
      dropdownIcon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      validator: validator ??
          (phone) {
            if (phone == null || phone.number.isEmpty) {
              return 'Le numéro de téléphone est requis.';
            }
            if (phone.number.length > 15) {
              return 'Le numéro ne peut pas dépasser 15 caractères.';
            }
            return null;
          },
      onChanged: onChanged,
      onSaved: onSaved,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
