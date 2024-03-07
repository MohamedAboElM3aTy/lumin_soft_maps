// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:map/data/repository/maps_repository.dart' as _i5;
import 'package:map/data/service/find_city_service.dart' as _i3;
import 'package:map/presentation/cubit/maps_cubit.dart' as _i6;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.FindCityService>(
      () => _i3.FindCityService(gh<_i4.Dio>()));
  gh.lazySingleton<_i5.MapsRepository>(
      () => _i5.MapsRepository(gh<_i3.FindCityService>()));
  gh.factory<_i6.MapsCubit>(() => _i6.MapsCubit(gh<_i5.MapsRepository>()));
  return getIt;
}
