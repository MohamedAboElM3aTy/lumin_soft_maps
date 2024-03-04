import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String name;
  final String password;

  const AppUser({
    required this.name,
    required this.password,
  });

  @override
  List<Object?> get props => [name, password];
}
