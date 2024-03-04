import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WaitingMapsContainer extends StatefulWidget {
  const WaitingMapsContainer({
    super.key,
  });

  @override
  State<WaitingMapsContainer> createState() => _WaitingMapsContainerState();
}

class _WaitingMapsContainerState extends State<WaitingMapsContainer> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          width: context.screenWidth * 0.7,
          height: context.screenHeight * 0.06,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Form(
              key: _formKey,
              child: const Center(
                child: Text('Waiting for a ride request ...'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }
    final location = await Geolocator.getCurrentPosition();
    return location;
  }
}
