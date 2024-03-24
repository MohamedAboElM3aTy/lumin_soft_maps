import 'package:equatable/equatable.dart';

class RideRequest extends Equatable {
  final String clientEmail;
  final String headLocation;
  final double headLatitude;
  final double headLongitude;
  final String? rideRequestId;

  const RideRequest({
    required this.clientEmail,
    required this.headLatitude,
    required this.headLocation,
    required this.headLongitude,
    this.rideRequestId,
  });

  @override
  List<Object?> get props => [
        clientEmail,
        headLatitude,
        headLocation,
        headLongitude,
        rideRequestId,
      ];
}
