import 'package:core/core.dart';
import 'package:flutter/material.dart';

class RidesCard extends StatelessWidget {
  const RidesCard({
    super.key,
    required this.clientEmail,
    required this.headLocation,
    required this.headLatitude,
    required this.headLongitude,
    required this.onDelete,
  });

  final String clientEmail;
  final String headLocation;
  final double headLatitude;
  final double headLongitude;
  final VoidCallback onDelete;

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
              Text('Client email: $clientEmail'),
              10.emptyHeight,
              Text('To: $headLocation'),
              10.emptyHeight,
              Text('Latitude: $headLatitude'),
              10.emptyHeight,
              Text('Longitude: $headLongitude'),
              10.emptyHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    width: context.screenWidth * 0.4,
                    height: context.screenHeight * 0.05,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      // horizontal: 10,
                    ),
                    label: 'Accept',
                    onPressed: () {
                      // Implement acceptance and draw map on both apps
                    },
                  ),
                  AppButton(
                    width: context.screenWidth * 0.4,
                    height: context.screenHeight * 0.05,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      // horizontal: 10,
                    ),
                    label: 'Reject',
                    // onPressed: () async {
                    //   // final collection = await FirebaseFirestore.instance
                    //       .collection('location')
                    //       .get();
                    //   // ! This deleted all the documents in the collection
                    //   // ? I want to delete the document with the same email or id
                    //   for (var location in collection.docChanges) {
                    //     location.doc.reference.delete();
                    //   }
                    // },
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
