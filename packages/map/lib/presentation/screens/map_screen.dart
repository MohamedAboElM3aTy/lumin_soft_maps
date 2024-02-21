import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map/presentation/widgets/maps_button.dart';
import 'package:map/presentation/widgets/request_ride_container.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final TextEditingController _locationController;
  late final FocusNode _locationFocusNode;

  @override
  void initState() {
    _locationController = TextEditingController();
    _locationFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  icon: Icons.chat_bubble,
                  onTap: () {},
                ),
                const LanguageButton(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: double.infinity,
              height: context.screenHeight * 0.2,
              decoration: BoxDecoration(
                color: Colors.grey[300]!.withOpacity(0.9),
              ),
            ),
          ),
          RequestRideContainer(locationController: _locationController),
        ],
      ),
    );
  }
}
