import 'package:beauty/utils/themes.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0xff28293D).withOpacity(.4),
            offset: const Offset(0, 0), // Ombre uniquement en bas
            blurRadius: 1,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0xff606170).withOpacity(.16),
            offset: const Offset(0, 2), // Ombre uniquement en bas
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: TextField(
        decoration: InputDecoration(
          counterText: '',
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppTheme.primaryYellow,
          ),
          hintStyle: TextStyle(
            color: AppTheme.disabledText,
            fontWeight: FontWeight.w400,
          ),
          hintText: 'Shop name or service',
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
