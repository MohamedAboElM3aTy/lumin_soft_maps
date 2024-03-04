// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapsResultApiModel _$MapsResultApiModelFromJson(Map<String, dynamic> json) =>
    MapsResultApiModel(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MapsResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MapsResultApiModelToJson(MapsResultApiModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

MapsResult _$MapsResultFromJson(Map<String, dynamic> json) => MapsResult(
      name: json['name'] as String?,
      country: json['country'] as String?,
      countryCode: json['country_code'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
      resultType: json['result_type'] as String?,
      formatted: json['formatted'] as String?,
      addressLine1: json['address_line1'] as String?,
      addressLine2: json['address_line2'] as String?,
      category: json['category'] as String?,
      plusCode: json['plus_code'] as String?,
      plusCodeShort: json['plus_code_short'] as String?,
      placeId: json['place_id'] as String?,
      street: json['street'] as String?,
      county: json['county'] as String?,
      district: json['district'] as String?,
      stateCode: json['state_code'] as String?,
      suburb: json['suburb'] as String?,
    );

Map<String, dynamic> _$MapsResultToJson(MapsResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'country_code': instance.countryCode,
      'state': instance.state,
      'city': instance.city,
      'lon': instance.lon,
      'lat': instance.lat,
      'result_type': instance.resultType,
      'formatted': instance.formatted,
      'address_line1': instance.addressLine1,
      'address_line2': instance.addressLine2,
      'category': instance.category,
      'plus_code': instance.plusCode,
      'plus_code_short': instance.plusCodeShort,
      'place_id': instance.placeId,
      'street': instance.street,
      'county': instance.county,
      'district': instance.district,
      'state_code': instance.stateCode,
      'suburb': instance.suburb,
    };
