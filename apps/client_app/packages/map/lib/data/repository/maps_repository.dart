import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:map/data/mapper/maps_mapper.dart';
import 'package:map/data/service/find_city_service.dart';
import 'package:map/domain/entity/map.dart';

@lazySingleton
class MapsRepository {
  final FindCityService _findCityService;

  MapsRepository(this._findCityService);

  Future<Either<GenericApplicationException, List<Maps>>> getCityLocation(
      String street) async {
    try {
      final result = await resolveOrThrow(
        () => _findCityService.getCityLocation(
          city: 'cairo',
          country: 'egypt',
          street: street,
        ),
      );
      final cities = (result.results ?? []).map((e) => e.toEntity()).toList();
      return Right(cities);
    } on GenericApplicationException catch (error) {
      return Left(error);
    }
  }
}
