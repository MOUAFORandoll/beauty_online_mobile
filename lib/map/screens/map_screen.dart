import 'package:beauty/map/widgets/place_label.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:beauty/map/widgets/status_bar.dart';
import 'package:beauty/map/widgets/search_bar_widget.dart';
import 'package:beauty/map/widgets/map_controls.dart';
import 'package:beauty/map/widgets/avatar_crowd.dart';
import 'package:beauty/map/widgets/bottom_navigation.dart';
import 'package:beauty/map/widgets/location_label.dart';
import 'package:beauty/map/widgets/profile_avatar.dart';
import 'package:beauty/map/widgets/weather_widget.dart';
import 'package:beauty/map/widgets/exploration_badge.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? _mapboxMap;
  bool _isMapInitialized = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MapboxOptions.setAccessToken(
        'pk.eyJ1IjoibW91YWZvIiwiYSI6ImNsbG5wemswczAzNDUzZ3A0Ym04OW5neTYifQ._k2VTUEp_qNXGJ5QPnk84g');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Mapbox Map Layer
          MapWidget(
            styleUri: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _onMapCreated,
            // cameraOptions: CameraOptions(
            //   center: Point(coordinates: Position(9.7679, 4.0511))
            //       .toJson(), // Douala coordinates
            //   zoom: 12.0,
            // ),
          ),

          // UI Overlay Elements
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),

                // Search Bar and Profile Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const ProfileAvatar(
                        imageUrl: "assets/images/profile.png",
                        showIndicator: true,
                        indicatorColor: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: SearchBarWidget(
                          text: "Douala",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon:
                              const Icon(Icons.settings, color: Colors.black54),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Weather Widget
                const Center(
                  child: WeatherWidget(
                    temperature: 81,
                    unit: "°F",
                    icon: Icons.thunderstorm,
                  ),
                ),

                const Spacer(),

                // Bottom Navigation
                const BottomNavigation(),
              ],
            ),
          ),

          // Navigation Button (Bottom Right)
          Positioned(
            right: 16,
            bottom: 100,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              // child: RotationTransition(
              //   turns: Animation<1>,
              child: IconButton(
                icon: const Icon(Icons.navigation, color: Colors.black),
                onPressed: () {},
              ),
              // ),
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(MapboxMap mapboxMap) async {
    _mapboxMap = mapboxMap;

    // Wait for the map to be fully loaded
    // await mapboxMap.style.styleLoaded();

    // Apply custom Snap Map style to the map
    // await MapboxUtils.applySnapMapStyle(mapboxMap);

    // Add location markers to the map
    await _addLocationMarkers();

    // Add avatar crowd to the map
    await _addAvatarCrowd();

    setState(() {
      _isMapInitialized = true;
    });
  }

  Future<void> _addLocationMarkers() async {
    if (_mapboxMap == null) return;

    // // Add location markers
    // await MapboxUtils.addLocationMarker(
    //   _mapboxMap!,
    //   'dibombari',
    //   9.6679,
    //   4.1511,
    //   'Dibombari',
    // );

    // await MapboxUtils.addLocationMarker(
    //   _mapboxMap!,
    //   'kwassa',
    //   9.6679,
    //   3.9511,
    //   'Kwassa Kwassa',
    //   'Populaire auprès\nde mes amis·es',
    //   true,
    // );

    // await MapboxUtils.addPlaceMarker(
    //   _mapboxMap!,
    //   'snobeuse',
    //   9.7279,
    //   3.9011,
    //   'Snobeuse et Dora',
    // );

    // await MapboxUtils.addPlaceMarker(
    //   _mapboxMap!,
    //   'coiffure',
    //   9.8279,
    //   3.9211,
    //   "ell'r coiffure\n& Soins",
    //   isPurple: true,
    // );
  }

  Future<void> _addAvatarCrowd() async {
    if (_mapboxMap == null) return;

    // await MapboxUtils.addAvatarCrowd(
    //   _mapboxMap!,
    //   'crowd',
    //   9.7679,
    //   4.0011,
    // );
  }
}

// class MapScreen extends StatelessWidget {
//   const MapScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Map Layer
//         FlutterMap(
//           options: MapOptions(
//             initialCenter: LatLng(4.0511, 9.7679), // Douala coordinates
//             initialZoom: 12.0,
//             maxZoom: 18.0,
//             minZoom: 3.0,
//             // interactiveFlags: InteractiveFlag.all,
//           ),
//           children: [
//             TileLayer(
//               urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//               // Custom tile styling to match the light green and blue water colors
//               tileBuilder: (context, widget, tile) {
//                 return ColorFiltered(
//                   colorFilter: const ColorFilter.matrix([
//                     0.9,
//                     0.1,
//                     0.1,
//                     0,
//                     0,
//                     0.1,
//                     0.9,
//                     0.1,
//                     0,
//                     10,
//                     0.1,
//                     0.1,
//                     0.9,
//                     0,
//                     0,
//                     0,
//                     0,
//                     0,
//                     1,
//                     0,
//                   ]),
//                   child: widget,
//                 );
//               },
//             ),

//             // Location Labels
//             const LocationLabel(
//               position: LatLng(4.1511, 9.6679),
//               label: "Dibombari",
//               fontSize: 18,
//             ),

//             const LocationLabel(
//               position: LatLng(3.9511, 9.6679),
//               label: "Kwassa Kwassa",
//               fontSize: 14,
//               subLabel: "Populaire auprès\nde mes amis·es",
//               subLabelColor: Colors.blue,
//             ),

//             // Place Labels
//             const PlaceLabel(
//               position: LatLng(3.9011, 9.7279),
//               label: "Snobeuse et Dora",
//               backgroundColor: Colors.white,
//               textColor: Colors.black,
//             ),

//             const PlaceLabel(
//               position: LatLng(3.9211, 9.8279),
//               label: "ell'r coiffure\n& Soins",
//               backgroundColor: Colors.transparent,
//               textColor: Colors.purple,
//             ),

//             // Avatar Crowd - This is the complex part with all the avatars
//             const AvatarCrowd(
//               position: LatLng(4.0011, 9.7679),
//               size: 200,
//             ),
//           ],
//         ),

//         // UI Overlay Elements
//         SafeArea(
//           child: Column(
//             children: [
//               const SizedBox(height: 8),

//               // Search Bar and Profile Row
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Row(
//                   children: [
//                     const ProfileAvatar(
//                       imageUrl: "assets/images/profile.png",
//                       showIndicator: true,
//                       indicatorColor: Colors.red,
//                     ),
//                     const SizedBox(width: 8),
//                     const Expanded(
//                       child: SearchBarWidget(
//                         text: "Douala",
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: IconButton(
//                         icon: const Icon(Icons.settings, color: Colors.black54),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 8),

//               // Weather Widget
//               const Center(
//                 child: WeatherWidget(
//                   temperature: 81,
//                   unit: "°F",
//                   icon: Icons.thunderstorm,
//                 ),
//               ),

//               const Spacer(),

//               // Bottom Navigation
//               const BottomNavigation(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
