// import 'package:core/app/constants/app_constants.dart';
// import 'package:core/core.dart';
// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:map/data/model/map_response_model.dart';
// import 'package:map/domain/entity/place.dart';
// import 'package:map/domain/entity/suggestion.dart';
// import 'package:retrofit/http.dart';

// part 'search_city_service.g.dart';

// @RestApi()
// @lazySingleton
// abstract class SearchCityService {
//   @factoryMethod
//   factory SearchCityService(Dio dio) = _SearchCityService;

//   @GET(AppConstants.searchApi)
//   Future<List<Suggestion>> fetchSearchSuggestions({
//     @Path('input') required String input,
//     @Path('language') required String lang,
//     @Path('component') required String component,
//     @Path('key') required String apiKey,
//     @Path('sessiontoken') required String sessiontoken,
//   });

//   @GET(AppConstants.detailsApi)
//   Future<Place> getPlaceDetail({
//     @Path('placeId') required String placeId,
//     @Path('key') required String apiKey,
//     @Path('sessiontoken') required String sessionToken,
//     @Path('fields') required String fields,
//   });
// }
