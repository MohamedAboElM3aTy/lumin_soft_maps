import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:driver_map/presentation/widgets/rides_card.dart';
import 'package:flutter/material.dart';

class HistoryRides extends StatelessWidget {
  const HistoryRides({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('location')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, locationSnapshots) {
        if (locationSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (!locationSnapshots.hasData ||
            locationSnapshots.data!.docs.isEmpty) {
          return Center(
            child: Text(
              context.getText('noLocation'),
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

        final loadedLocations = locationSnapshots.data!.docs;
        return Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => 20.emptyHeight,
            itemBuilder: (ctx, index) {
              final headLocation = loadedLocations[index].data();
              return RidesCard(
                clientEmail: headLocation['userEmail'],
                headLocation: headLocation['headLocation'],
                headLatitude: headLocation['headLatitude'],
                headLongitude: headLocation['headLongitude'],
                onDelete: () async {
                  await loadedLocations[index].reference.delete();
                },
              );
            },
            itemCount: loadedLocations.length,
          ),
        );
      },
    );
  }
}
