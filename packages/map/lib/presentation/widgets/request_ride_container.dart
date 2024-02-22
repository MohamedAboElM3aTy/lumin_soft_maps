import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:map/presentation/widgets/build_row.dart';

class RequestRideContainer extends StatelessWidget {
  const RequestRideContainer({
    super.key,
    required this.locationController,
  });

  final TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          width: double.infinity,
          height: context.screenHeight * 0.32,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedTextField(
                  isMap: true,
                  controller: locationController,
                  icon: Icons.search,
                  changed: (location) => locationController.text = location,
                  validator: (location) => location!.isEmpty
                      ? context.getText('locationRequired')
                      : null,
                  hintText: context.getText('whereTo'),
                  hintStyle: context.textTheme.labelMedium?.copyWith(
                    fontSize: 20.toFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                BuildRow(labelText: context.getText('egypt')),
                const Divider(thickness: 0.4),
                BuildRow(labelText: context.getText('london')),
                AppButton(
                  width: context.screenWidth * 0.9,
                  borderRadius: 20,
                  textStyle: context.textTheme.labelLarge?.copyWith(
                    fontSize: 20.toFont,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  // ! To implement Handling Notification
                  onPressed: _getLocation,
                  label: context.getText('requestRide'),
                ),
                0.01.toHeight.emptyHeight,
                // 2.emptyHeight,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _getLocation() async {
  Location location = Location();
  bool isServiceEnabled;
  PermissionStatus isPermissionGranted;
  LocationData locationData;

  isServiceEnabled = await location.serviceEnabled();
  if (!isServiceEnabled) {
    isServiceEnabled = await location.requestService();
    if (!isServiceEnabled) {
      return;
    }
  }

  isPermissionGranted = await location.hasPermission();
  if (isPermissionGranted == PermissionStatus.denied) {
    isPermissionGranted = await location.requestPermission();
    if (isPermissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locationData = await location.getLocation();
  debugPrint(locationData.latitude.toString());
  debugPrint(locationData.longitude.toString());
}
