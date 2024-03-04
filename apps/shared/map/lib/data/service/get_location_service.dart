import 'dart:io';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:map/domain/entity/place.dart';
import 'package:map/domain/entity/suggestion.dart';

class PlaceApiProvider {
  final Dio _dio = Dio();

  final sessionToken;

  final apiKey = Platform.isAndroid
      ? AppConstants.googleAndroidApiKey
      : AppConstants.googleIosApiKey;

  PlaceApiProvider(this.sessionToken) {
    _dio.interceptors.add(
      LogInterceptor(responseBody: true),
    );
  }

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    try {
      final response = await resolveOrThrow(
        () => _dio.get(
          AppConstants.searchApi,
          queryParameters: {
            'input': input,
            'types': 'address',
            'language': lang,
            'components': 'country:EG',
            'key': apiKey,
            'sessiontoken': sessionToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        final result = response.data;
        if (result['status'] == 'OK') {
          return (result['predictions'] as List)
              .map<Suggestion>(
                (suggestion) => Suggestion(
                  suggestion['place_id'],
                  suggestion['description'],
                ),
              )
              .toList();
        }
        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to fetch suggestion: $error');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    try {
      final response = await resolveOrThrow(
        () => _dio.get(
          AppConstants.detailsApi,
          queryParameters: {
            'place_id': placeId,
            'fields': 'address_component',
            'key': apiKey,
            'sessiontoken': sessionToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        final result = response.data;
        if (result['status'] == 'OK') {
          final components =
              result['result']['address_components'] as List<dynamic>;
          final place = Place();
          for (var component in components) {
            final List type = component['types'];
            if (type.contains('street_number')) {
              place.streetNumber = component['long_name'];
            }
            if (type.contains('route')) {
              place.street = component['long_name'];
            }
            if (type.contains('locality')) {
              place.city = component['long_name'];
            }
            if (type.contains('postal_code')) {
              place.zipCode = component['long_name'];
            }
          }
          return place;
        }
        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch place details');
      }
    } catch (e) {
      throw Exception('Failed to fetch place details: $e');
    }
  }
}
