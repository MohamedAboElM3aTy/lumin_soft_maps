import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.loading() = _Loading;

  const factory AuthState.authenticated({
    required User user,
  }) = _Authenticated;

  const factory AuthState.loggedOut() = _LoggedOut;

  const factory AuthState.unAuthenticated() = _UnAuthenticated;

  const factory AuthState.error({required String message}) = _Error;
}
