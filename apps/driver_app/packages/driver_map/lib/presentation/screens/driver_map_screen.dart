import 'package:core/core.dart';
import 'package:driver_map/presentation/widgets/maps_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map/presentation/widgets/maps_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverMapScreen extends StatefulWidget {
  const DriverMapScreen({super.key});

  @override
  State<DriverMapScreen> createState() => _DriverMapScreenState();
}

class _DriverMapScreenState extends State<DriverMapScreen> {
  List<Marker> markers = [];

  @override
  void initState() {
    _addInitialMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(30.033333, 31.233334),
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () {
                        launchUrl(
                          Uri.parse('https://openstreetmap.org/copyright'),
                        );
                      },
                    ),
                  ],
                ),
                MarkerLayer(markers: markers),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25.0,
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MapsFloatingButton(
                    heroTag: 'map_floating_button_2',
                    icon: Icons.chat_bubble,
                    onTap: () => context.navigator.pushNamed(
                      AppRoutes.chatRoute,
                      arguments: {},
                    ),
                  ),
                  MapsFloatingButton(
                    heroTag: 'history_button',
                    icon: Icons.history,
                    onTap: () => context.navigator.pushNamed(
                      AppRoutes.historyRoute,
                    ),
                  ),
                ],
              ),
            ),
            const WaitingMapsContainer(),
          ],
        ),
      ),
    );
  }

  void _addInitialMarker() {
    markers.add(
      const Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(30.090984, 31.322708), // Initial Egypt coordinates
        child: Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40.0,
        ),
      ),
    );
  }
}
