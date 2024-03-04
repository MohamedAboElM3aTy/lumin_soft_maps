import 'package:core/app/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:map/data/model/map_response_model.dart';
import 'package:retrofit/http.dart';

part 'find_city_service.g.dart';

@RestApi()
@lazySingleton
abstract class FindCityService {
  @factoryMethod
  factory FindCityService(Dio dio) => _FindCityService(dio);

  @GET(
    'https://api.geoapify.com/v1/geocode/search?city={city}&text={text}&street={street}&format=json&apiKey=${AppConstants.apiKey}',
  )
  Future<MapsResultApiModel> getCityLocation({
    @Path('city') required String city,
    @Path('text') required String country,
    @Path('street') required String street,
  });
}

