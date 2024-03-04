import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Place extends Equatable {
  String? streetNumber;
  String? street;
  String? city;
  String? zipCode;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString() =>
      'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';

  @override
  List<Object?> get props => [streetNumber, street, city, zipCode];
}
