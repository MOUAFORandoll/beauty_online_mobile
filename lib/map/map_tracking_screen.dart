import 'package:beauty/common/models/professional.dart';
import 'package:beauty/common/utils/themes.dart';
import 'package:beauty/map/bloc/map_tracking_cubit.dart';
import 'package:beauty/map/bloc/map_tracking_state.dart';
import 'package:beauty/map/directions_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTrackingScreen extends StatefulWidget {
  final Professional professional;

  const MapTrackingScreen({
    Key? key,
    required this.professional,
  }) : super(key: key);

  @override
  State<MapTrackingScreen> createState() => _MapTrackingScreenState();
}

class _MapTrackingScreenState extends State<MapTrackingScreen> {
  late GoogleMapController _mapController;

  late final mapTracking = context.read<MapTrackingCubit>();
  @override
  void initState() {
    // TODO: implement initState
    // mapTracking.start();
    mapTracking.startTracking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double spaceWidth = MediaQuery.of(context).size.width / 4.5;
    return Scaffold(
      body: BlocConsumer<MapTrackingCubit, MapTrackingState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              // SizedBox(
              //   height: 400,
              // child:
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                  // Sélectionner le professionnel automatiquement
                  context
                      .read<MapTrackingCubit>()
                      .selectProfessional(widget.professional);
                },

                initialCameraPosition: CameraPosition(
                  target: state.clientLocation ?? const LatLng(0, 0),
                  zoom: 14,
                ),
                zoomControlsEnabled: false,
                markers: state.markers,
                polylines: state.polylines,
                myLocationEnabled: true,
                indoorViewEnabled: true,
                myLocationButtonEnabled: false,
                trafficEnabled: true,
                onCameraMove: (CameraPosition position) {
                  print("==========$position");
                  print("==========${position.toString()}");
                  // Optionnel: actions lors du déplacement de la caméra
                },
                // ),
              ),
              Positioned(
                top: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.primaryBlack),
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.close, color: Colors.white)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(
                      width: spaceWidth,
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppTheme.primaryYellow),
                        child: Text(
                          '${widget.professional.namePro}',
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(
                      width: spaceWidth,
                    ),
                    BlocBuilder<MapTrackingCubit, MapTrackingState>(
                      builder: (context, state) {
                        return IconButton(
                          icon: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.primaryBlack),
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                  state.isTracking
                                      ? Icons.stop
                                      : Icons.play_arrow,
                                  color: Colors.white)),
                          onPressed: () {
                            if (state.isTracking) {
                              mapTracking.stopTracking();

                              // context.read<MapTrackingCubit>().add(
                              //       const MapTrackingEvent.trackingStopped(),
                              //     );
                            } else {
                              mapTracking.startTracking();

                              // context.read<MapTrackingCubit>().add(
                              //       const MapTrackingEvent.trackingStarted(),
                              //     );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: BlocBuilder<MapTrackingCubit, MapTrackingState>(
        builder: (context, state) {
          if (state.clientLocation != null &&
              state.professionalLocation != null) {
            return FloatingActionButton(
              onPressed: () {
                _fitMapToShowBothLocations(state);
              },
              child: const Icon(Icons.center_focus_strong),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _fitMapToShowBothLocations(MapTrackingState state) {
    if (_mapController != null &&
        state.clientLocation != null &&
        state.professionalLocation != null) {
      final bounds = LatLngBounds(
        southwest: LatLng(
          state.clientLocation!.latitude < state.professionalLocation!.latitude
              ? state.clientLocation!.latitude
              : state.professionalLocation!.latitude,
          state.clientLocation!.longitude <
                  state.professionalLocation!.longitude
              ? state.clientLocation!.longitude
              : state.professionalLocation!.longitude,
        ),
        northeast: LatLng(
          state.clientLocation!.latitude > state.professionalLocation!.latitude
              ? state.clientLocation!.latitude
              : state.professionalLocation!.latitude,
          state.clientLocation!.longitude >
                  state.professionalLocation!.longitude
              ? state.clientLocation!.longitude
              : state.professionalLocation!.longitude,
        ),
      );

      _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 100),
      );
    }
  }
}
