import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:map/data/repository/maps_repository.dart';
import 'package:map/domain/entity/map.dart';

part 'maps_cubit.freezed.dart';
part 'maps_state.dart';

@injectable
class MapsCubit extends Cubit<MapsState> {
  final MapsRepository _mapsRepository;
  MapsCubit(this._mapsRepository) : super(const MapsState.initial());

  Future<void> getCityLocation({
    required String street,
  }) async {
    emit(const MapsState.loading());
    final result = await _mapsRepository.getCityLocation(street);
    result.fold(
      (error) => emit(MapsState.error(message: error.message)),
      (maps) => emit(MapsState.success(mapsEntity: maps.first)),
    );
  }
}
