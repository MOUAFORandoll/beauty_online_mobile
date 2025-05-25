import 'package:beauty/common/models/catalogue.dart';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/home/models/actu.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_result.freezed.dart';
part 'search_result.g.dart';

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String type,
    required String title,
    required String url,
    required dynamic data,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

// Ici, on ajoute notre méthode personnalisée en extension :
extension SearchResultX on SearchResult {
  /// Renvoie un objet Actu ou Professional selon [type], ou null sinon.
  dynamic formatData() {
    switch (type) {
      case 'actu':
        return Actu.fromJson(data as Map<String, dynamic>);
      case 'pro':
        return Professional.fromJson(data as Map<String, dynamic>);
      default:
        return null;
    }
  }
}
