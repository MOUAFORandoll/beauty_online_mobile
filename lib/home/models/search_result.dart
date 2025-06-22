import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:beauty/home/screens/sub/actu_screen.dart';
import 'package:beauty/professional/screens/client_professional_board.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'search_result.freezed.dart';
part 'search_result.g.dart';

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String type,
    required String title,
    required String description,
    required String url,
    required dynamic data,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

// Ici, on ajoute notre méthode personnalisée en extension :
extension SearchResultX on SearchResult {
  /// Renvoie un objet Actu ou Professional selon [type], ou null sinon.
  dynamic navigateTo(context) {
    switch (type) {
      case 'actu':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ActuScreen.get(
                context: context,
                actu: Actu.fromJson(data as Map<String, dynamic>)),
          ),
        );
      case 'pro':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ClientProfessionalBoard.get(
                context: context,
                professional:
                    Professional.fromJson(data as Map<String, dynamic>)),
          ),
        );
        return;
      default:
        return null;
    }
  }

  dynamic toData() {
    switch (type) {
      case 'actu':
        Actu.fromJson(data as Map<String, dynamic>);

      case 'pro':
     Professional.fromJson(data as Map<String, dynamic>);
        return;
      default:
        return null;
    }
  }
}
