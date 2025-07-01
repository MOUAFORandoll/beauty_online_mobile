import 'dart:async';
import 'dart:developer';
import 'package:beauty/common/models/professional.dart';
import 'package:beauty/common/services/geolocation_service.dart';
import 'package:beauty/common/utils/assets.dart';
import 'package:beauty/map/bloc/map_tracking_cubit.dart';
import 'package:beauty/map/directions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_tracking_state.dart';

class MapTrackingCubit extends Cubit<MapTrackingState> {
  final GeolocationService locationService;
  final DirectionsService directionsService;
  StreamSubscription<geo.Position>? _locationSubscription;

  MapTrackingCubit(
    this.locationService,
    this.directionsService,
  ) : super(MapTrackingState());

  Future<void> start() async {
    emit(state.copyWith(isLoading: true));
    try {
      final position = await locationService.getCurrentLocation();
      final clientLocation = LatLng(position.latitude, position.longitude);
      log('===========${clientLocation.toJson()}');
      print('===========${clientLocation.toJson()}');
      emit(state.copyWith(
        isLoading: false,
        clientLocation: clientLocation,
        markers: {
          Marker(
            markerId: const MarkerId('client'),
            position: clientLocation,
            infoWindow: const InfoWindow(title: 'Votre position'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        },
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Erreur lors de la récupération de la position : $e',
      ));
    }
  }

  Future<BitmapDescriptor> _loadCustomMarker(
      {required String assetPath, double taille = 32}) async {
    return await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(taille, taille)), // Taille de l'image
      assetPath,
    );
  }

  Future<void> selectProfessional(Professional professional) async {
    if (professional.position?.latitude == null ||
        professional.position?.longitude == null) {
      emit(state.copyWith(error: 'Position du professionnel non disponible'));
      return;
    }

    final professionalLocation = LatLng(
      double.parse(professional.position!.latitude!),
      double.parse(professional.position!.longitude!),
    );

    final updatedMarkers = Set<Marker>.from(state.markers)
      ..add(
        Marker(
          markerId: const MarkerId('professional'),
          position: professionalLocation,
          infoWindow: InfoWindow(
            title: professional.namePro,
            snippet: professional.description,
          ),
          icon: await _loadCustomMarker(assetPath: Assets.pinPro, taille: 56),
          // BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );

    emit(state.copyWith(
      selectedProfessional: professional,
      professionalLocation: professionalLocation,
      markers: updatedMarkers,
    ));

    if (state.clientLocation != null) {
      await _calculateRoute();
    }
  }

  Future<void> updateClientLocation(LatLng location) async {
    final updatedMarkers = Set<Marker>.from(state.markers)
      ..removeWhere((marker) => marker.markerId.value == 'client')
      ..add(
        Marker(
          markerId: const MarkerId('client'),
          position: location,
          infoWindow: const InfoWindow(title: 'Votre position'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );

    emit(state.copyWith(
      clientLocation: location,
      markers: updatedMarkers,
    ));

    if (state.professionalLocation != null) {
      await _calculateRoute();
    }
  }

  Future<void> startTracking() async {
    emit(state.copyWith(isTracking: true));
    _locationSubscription =
        locationService.getLocationStream().listen((position) {
      updateClientLocation(LatLng(position.latitude, position.longitude));
    });
  }

  Future<void> stopTracking() async {
    emit(state.copyWith(isTracking: false));
    await _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  Future<void> _calculateRoute() async {
    if (state.clientLocation == null || state.professionalLocation == null)
      return;

    try {
      final directions = await directionsService.getDirections(
        origin: state.clientLocation!,
        destination: LatLng(
          3.8431237,
          11.5324795,
        ),
        //state.professionalLocation!,
      );

      final routePolyline = Polyline(
        polylineId: const PolylineId('route'),
        points: directions.polylinePoints,
        color: const Color(0xFF2196F3),
        width: 5,
      );

      emit(state.copyWith(
        polylines: {routePolyline},
        distance: directions.distance,
        duration: directions.duration,
        estimatedArrival: directions.estimatedArrival,
      ));
    } catch (e) {
      log('======Erreur lors du calcul de la route: $e');
      print('======Erreur lors du calcul de la route: $e');
      emit(state.copyWith(error: 'Erreur lors du calcul de la route: $e'));
    }
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
