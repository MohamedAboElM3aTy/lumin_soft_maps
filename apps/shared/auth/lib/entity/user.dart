import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool isClient;

  const AppUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.isClient,
  });

  @override
  List<Object?> get props => [firstName, lastName, email, isClient, password];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'isClient': isClient,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      isClient: map['isClient'] as bool,
    );
  }
}
