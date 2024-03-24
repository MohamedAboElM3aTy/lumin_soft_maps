import 'package:core/core.dart';
import 'package:driver_map/domain/rides_request.dart';
import 'package:flutter/material.dart';

class RidesCard extends StatelessWidget {
  const RidesCard({
    super.key,
    required this.rideRequest,
    required this.onDelete,
    required this.onAccept,
  });
  final RideRequest rideRequest;
  final VoidCallback onDelete;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth * 0.9,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Client Email: ${rideRequest.clientEmail}'),
              10.emptyHeight,
              Text('To: ${rideRequest.headLocation}'),
              10.emptyHeight,
              Text('Latitude: ${rideRequest.headLatitude}'),
              10.emptyHeight,
              Text('Longitude: ${rideRequest.headLongitude}'),
              10.emptyHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    width: context.screenWidth * 0.4,
                    height: context.screenHeight * 0.05,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    label: context.getText('accept'),
                    onPressed: onAccept,
                  ),
                  AppButton(
                    width: context.screenWidth * 0.4,
                    height: context.screenHeight * 0.05,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    label: context.getText('reject'),
                    onPressed: onDelete,
                    backgroundColor: const Color.fromARGB(255, 242, 13, 47),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
