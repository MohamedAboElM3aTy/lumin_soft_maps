import 'package:map/data/model/map_response_model.dart';
import 'package:map/domain/entity/map.dart';

extension MapsMapper on MapsResult {
  Maps toEntity() => Maps(
        cityName: city ?? '',
        countryName: country ?? '',
        streetName: street ?? '',
        latitude: lat ?? 0.0,
        longitude: lon ?? 0.0,
      );
}
