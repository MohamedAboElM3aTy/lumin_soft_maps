import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:map/data/service/get_location_service.dart';
import 'package:map/presentation/widgets/address_search.dart';
import 'package:uuid/uuid.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _locationController;
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';

  @override
  void initState() {
    _locationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        title: Text(
          'Search Screen',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 22.toFont,
          ),
        ),
      ),
      body: Column(
        children: [
          20.emptyHeight,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: RoundedTextField(
              isMap: true,
              controller: _locationController,
              changed: (location) => _locationController.text = location,
              validator: (location) => location!.isEmpty
                  ? context.getText('locationRequired')
                  : null,
              hintText: context.getText('whereTo'),
              icon: Icons.search,
              onTap: () async {
                final sessionToken = const Uuid().v4();
                final result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );
                if (result != null) {
                  final placeDetails = await PlaceApiProvider(sessionToken)
                      .getPlaceDetailFromId(result.placeId);
                  setState(
                    () {
                      _locationController.text = result.description;
                      _streetNumber = placeDetails.streetNumber ?? '';
                      _street = placeDetails.street ?? '';
                      _city = placeDetails.city ?? '';
                      _zipCode = placeDetails.zipCode ?? '';
                    },
                  );
                }
              },
            ),
          ),
          20.emptyHeight,
          Text('location Controller: ${_locationController.text}'),
          Text('Street Number: $_streetNumber'),
          Text('Street: $_street'),
          Text('City: $_city'),
          Text('ZIP Code: $_zipCode'),
        ],
      ),
    );
  }
}
