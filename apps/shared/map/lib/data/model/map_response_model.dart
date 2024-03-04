import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_response_model.g.dart';

@JsonSerializable()
class MapsResultApiModel {
  @JsonKey(name: "results")
  List<MapsResult>? results;

  MapsResultApiModel({
    this.results,
  });

  factory MapsResultApiModel.fromJson(Map<String, dynamic> json) =>
      _$MapsResultApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapsResultApiModelToJson(this);
}

@JsonSerializable()
class MapsResult {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "country")
  String? country;
  @JsonKey(name: "country_code")
  String? countryCode;
  @JsonKey(name: "state")
  String? state;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "lon")
  double? lon;
  @JsonKey(name: "lat")
  double? lat;
  @JsonKey(name: "result_type")
  String? resultType;
  @JsonKey(name: "formatted")
  String? formatted;
  @JsonKey(name: "address_line1")
  String? addressLine1;
  @JsonKey(name: "address_line2")
  String? addressLine2;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "plus_code")
  String? plusCode;
  @JsonKey(name: "plus_code_short")
  String? plusCodeShort;
  @JsonKey(name: "place_id")
  String? placeId;
  @JsonKey(name: "street")
  String? street;
  @JsonKey(name: "county")
  String? county;
  @JsonKey(name: "district")
  String? district;
  @JsonKey(name: "state_code")
  String? stateCode;
  @JsonKey(name: "suburb")
  String? suburb;

  MapsResult({
    this.name,
    this.country,
    this.countryCode,
    this.state,
    this.city,
    this.lon,
    this.lat,
    this.resultType,
    this.formatted,
    this.addressLine1,
    this.addressLine2,
    this.category,
    this.plusCode,
    this.plusCodeShort,
    this.placeId,
    this.street,
    this.county,
    this.district,
    this.stateCode,
    this.suburb,
  });

  factory MapsResult.fromJson(Map<String, dynamic> json) =>
      _$MapsResultFromJson(json);

  Map<String, dynamic> toJson() => _$MapsResultToJson(this);
}
