import 'package:equatable/equatable.dart';

class Suggestion extends Equatable {
  final String placeId;
  final String description;

  const Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }

  @override
  List<Object?> get props => [placeId, description];
}
