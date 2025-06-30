import 'dart:async';
import 'package:beauty/common/models/professional.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

class MapTrackingState {
  final bool isLoading;
  final bool isTracking;
  final LatLng? clientLocation;
  final LatLng? professionalLocation;
  final Professional? selectedProfessional;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final String? error;
  final double? distance;
  final String? duration;
  final String? estimatedArrival;

  MapTrackingState({
    this.isLoading = false,
    this.isTracking = false,
    this.clientLocation,
    this.professionalLocation,
    this.selectedProfessional,
    this.markers = const {},
    this.polylines = const {},
    this.error,
    this.distance,
    this.duration,
    this.estimatedArrival,
  });

  MapTrackingState copyWith({
    bool? isLoading,
    bool? isTracking,
    LatLng? clientLocation,
    LatLng? professionalLocation,
    Professional? selectedProfessional,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    String? error,
    double? distance,
    String? duration,
    String? estimatedArrival,
  }) {
    return MapTrackingState(
      isLoading: isLoading ?? this.isLoading,
      isTracking: isTracking ?? this.isTracking,
      clientLocation: clientLocation ?? this.clientLocation,
      professionalLocation: professionalLocation ?? this.professionalLocation,
      selectedProfessional: selectedProfessional ?? this.selectedProfessional,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      error: error,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      estimatedArrival: estimatedArrival ?? this.estimatedArrival,
    );
  }
}

 