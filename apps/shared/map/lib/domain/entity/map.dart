import 'package:equatable/equatable.dart';

class Maps extends Equatable {
  final String cityName;
  final String countryName;
  final String streetName;
  final double latitude;
  final double longitude;

  const Maps({
    required this.cityName,
    required this.streetName,
    required this.countryName,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        cityName,
        countryName,
        streetName,
        latitude,
        longitude,
      ];
}
