import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map/presentation/cubit/maps_cubit.dart';
import 'package:map/presentation/widgets/build_row.dart';

class RequestRideContainer extends StatefulWidget {
  const RequestRideContainer({
    super.key,
    required this.streetController,
  });

  final TextEditingController streetController;

  @override
  State<RequestRideContainer> createState() => _RequestRideContainerState();
}

class _RequestRideContainerState extends State<RequestRideContainer> {
  late final GlobalKey<FormState> _formKey;
  late final MapsCubit _mapsCubit;
  double headLatitude = 0.0;
  double headLongitude = 0.0;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _mapsCubit = context.read<MapsCubit>();
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedTextField(
                    // onTap: () async {
                    //   final sessionToken = const Uuid().v4();
                    //   final result = await showSearch(
                    //     context: context,
                    //     delegate: AddressSearch(sessionToken),
                    //   );
                    //   if (result != null) {
                    //     final placeDetails =
                    //         await PlaceApiProvider(sessionToken)
                    //             .getPlaceDetailFromId(result.placeId);
                    //     debugPrint(placeDetails.street.toString());
                    //   }
                    // },
                    isMap: true,
                    controller: widget.streetController,
                    icon: Icons.search,
                    changed: (location) =>
                        widget.streetController.text = location,
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
                  BlocConsumer<MapsCubit, MapsState>(
                    bloc: _mapsCubit,
                    listener: (context, state) {
                      state.maybeMap(
                        orElse: () {},
                        error: (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error.message!)),
                          );
                        },
                        success: (map) {
                          headLatitude = map.mapsEntity.latitude;
                          headLongitude = map.mapsEntity.longitude;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Column(
                                children: [
                                  Text(map.mapsEntity.latitude.toString()),
                                  Text(map.mapsEntity.longitude.toString()),
                                  Text(map.mapsEntity.streetName),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    builder: (context, state) {
                      return AppButton(
                        isLoading: state.maybeWhen(
                          orElse: () => false,
                          loading: () => true,
                        ),
                        label: context.getText('requestRide'),
                        width: context.screenWidth * 0.9,
                        borderRadius: 20,
                        textStyle: context.textTheme.labelLarge?.copyWith(
                          fontSize: 20.toFont,
                          fontWeight: FontWeight.w400,
                          color: AppColors.whiteColor,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        onPressed: _searchAndSubmit,
                      );
                    },
                  ),
                  0.01.toHeight.emptyHeight,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _searchAndSubmit() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      final streetName = widget.streetController.text;
      final user = FirebaseAuth.instance.currentUser;
      final collection = FirebaseFirestore.instance.collection('location');
      await _mapsCubit.getCityLocation(street: streetName);
      final latitude = await _getCurrentLocation().then(
        (currentLocation) => currentLocation.latitude,
      );
      final longitude = await _getCurrentLocation().then(
        (currentLocation) => currentLocation.longitude,
      );
      await _showDialog(streetName: streetName);
      await collection.add(
        {
          'createdAt': Timestamp.now(),
          'userId': user!.uid,
          'userLatitude': latitude,
          'userLongitude': longitude,
          'userEmail': user.email,
          'headLocation': streetName,
          'headLatitude': headLatitude,
          'headLongitude': headLongitude,
          'status': 'pending'
        },
      );
      _formKey.currentState!.reset();
    }
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

  Future<void> _showDialog({required String streetName}) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ShowAlertDialog(streetName: streetName),
    );
  }
}
