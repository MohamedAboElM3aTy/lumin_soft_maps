import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map/di/injection_container.dart';
import 'package:map/presentation/cubit/maps_cubit.dart';
import 'package:map/presentation/widgets/maps_button.dart';
import 'package:map/presentation/widgets/request_ride_container.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientMapScreen extends StatefulWidget {
  const ClientMapScreen({super.key});

  @override
  State<ClientMapScreen> createState() => _ClientMapScreenState();
}

class _ClientMapScreenState extends State<ClientMapScreen> {
  late final TextEditingController _streetController;
  late final MapsCubit _mapsCubit;
  List<Marker> markers = [];

  @override
  void initState() {
    _streetController = TextEditingController();
    _mapsCubit = mapsGetIt<MapsCubit>();
    _addInitialMarker();
    super.initState();
  }

  @override
  void dispose() {
    _streetController.dispose();
    _mapsCubit.close();
    super.dispose();
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
                    icon: Icons.chat_bubble,
                    onTap: () => context.navigator.pushNamed(
                      AppRoutes.chatRoute,
                      arguments: {},
                    ),
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
            BlocProvider.value(
              value: _mapsCubit,
              child: RequestRideContainer(streetController: _streetController),
            ),
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

  void _addMarker(double latitude, double longitude) {
    setState(
      () {
        markers.add(
          Marker(
            width: 40.0,
            height: 40.0,
            point: LatLng(latitude, longitude),
            child: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 40.0,
            ),
          ),
        );
      },
    );
  }
}
