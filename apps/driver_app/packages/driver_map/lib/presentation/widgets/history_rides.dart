import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:driver_map/domain/rides_request.dart';
import 'package:driver_map/presentation/widgets/rides_card.dart';
import 'package:flutter/material.dart';

class HistoryRides extends StatelessWidget {
  const HistoryRides({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('rideRequests')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, locationSnapshots) {
        if (locationSnapshots.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        }
        if (!locationSnapshots.hasData ||
            locationSnapshots.data!.docs.isEmpty) {
          return Center(
            child: Text(
              context.getText('noRides'),
              style: context.textTheme.labelMedium?.copyWith(
                fontSize: 20.toFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        locationSnapshots.hasError
            ? EmptyScreen(
                message: locationSnapshots.error.toString(),
              )
            : null;
        final loadedRides = locationSnapshots.data!.docs;
        return Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => 20.emptyHeight,
            itemCount: loadedRides.length,
            itemBuilder: (ctx, index) {
              final rideRequest = loadedRides[index].data();
              return RidesCard(
                rideRequest: RideRequest(
                  clientEmail: rideRequest['userEmail'],
                  headLocation: rideRequest['headLocation'],
                  headLatitude: rideRequest['headLatitude'],
                  headLongitude: rideRequest['headLongitude'],
                ),
                onDelete: () async {
                  await loadedRides[index].reference.delete();
                },
                onAccept: () async {
                  debugPrint('Accept Button Tapped');
                  final rideId = loadedRides[index].id;
                  final responseCollection =
                      FirebaseFirestore.instance.collection('rideResponses');
                  try {
                    await FirebaseFirestore.instance
                        .collection('rideRequests')
                        .doc(rideId)
                        .update(
                      {
                        'status': 'accepted',
                      },
                    );
                    await responseCollection.add(
                      {
                        'ride_id': rideId,
                        'status': 'accepted',
                        'headLocation': rideRequest['headLocation'],
                        'time': Timestamp.now(),
                      },
                    );
                    // TODO: To Refactor to push to the chat directly when accepting ride
                    context.navigator.pushNamed(AppRoutes.chatRoute);
                  } catch (error) {
                    debugPrint(error.toString());
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}
