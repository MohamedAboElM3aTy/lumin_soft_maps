import 'package:auth/data/services/auth_service.dart';
import 'package:auth/presentation/cubit/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthBase _authBase;

  AuthCubit(this._authBase) : super(const AuthState.initial());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthState.loading());
      final user = await _authBase.login(email, password);
      if (user != null) {
        emit(AuthState.authenticated(user: user));
      } else {
        emit(const AuthState.unAuthenticated());
      }
    } on GenericApplicationException catch (error) {
      emit(AuthState.error(message: error.toString()));
    }
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthState.loading());
      final user = await _authBase.register(email, password);
      if (user != null) {
        emit(AuthState.authenticated(user: user));
      } else {
        emit(const AuthState.unAuthenticated());
      }
    } on GenericApplicationException catch (error) {
      emit(AuthState.error(message: error.toString()));
    }
  }

  Future<void> logOut() async {
    try {
      emit(const AuthState.loading());
      await _authBase.logout();
      emit(const AuthState.loggedOut());
    } on GenericApplicationException catch (error) {
      emit(AuthState.error(message: error.toString()));
    }
  }
}
