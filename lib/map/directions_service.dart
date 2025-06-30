import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

class DirectionsResult {
  final List<LatLng> polylinePoints;
  final double distance;
  final String duration;
  final String estimatedArrival;

  DirectionsResult({
    required this.polylinePoints,
    required this.distance,
    required this.duration,
    required this.estimatedArrival,
  });
}

class DirectionsService {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json';
  final String apiKey;

  DirectionsService({this.apiKey = 'AIzaSyA3XYSJru7Q3Y5OKQtOLi1TJWTXRWHDLaI'});

  Future<DirectionsResult> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final String url = '$_baseUrl?'
        'origin=${origin.latitude},${origin.longitude}&'
        'destination=${destination.latitude},${destination.longitude}&'
        'key=$apiKey&'
        'mode=driving&'
        'departure_time=now&'
        'traffic_model=best_guess';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final route = data['routes'][0];
        final leg = route['legs'][0];

        // Décoder les points de la polyline
        final polylinePoints = decodePolyline(
                route['overview_polyline']['points'])
            .map((point) => LatLng(point[0].toDouble(), point[1].toDouble()))
            .toList();

        // Extraire les informations de distance et durée
        final distance = leg['distance']['value'] / 1000.0; // Convertir en km
        final duration = leg['duration']['text'];

        // Calculer l'heure d'arrivée estimée
        final durationInSeconds = leg['duration']['value'];
        final arrivalTime =
            DateTime.now().add(Duration(seconds: durationInSeconds));
        final estimatedArrival =
            '${arrivalTime.hour.toString().padLeft(2, '0')}:${arrivalTime.minute.toString().padLeft(2, '0')}';



 
        return DirectionsResult(
          polylinePoints: polylinePoints,
          distance: distance,
          duration: duration,
          estimatedArrival: estimatedArrival,
        );
      } else {
        throw Exception('Erreur API Directions: ${data['status']}');
      }
    } else {
      throw Exception('Erreur HTTP: ${response.statusCode}');
    }
  }
}
