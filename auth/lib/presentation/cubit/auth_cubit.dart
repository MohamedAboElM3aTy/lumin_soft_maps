import 'package:auth/data/services/auth_service.dart';
import 'package:auth/presentation/cubit/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(const AuthState.initial());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthState.loading());
      final user = await _authService.login(email, password);
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
    required String email,
    required String password,
  }) async {
    try {
      emit(const AuthState.loading());
      final user = await _authService.register(email, password);
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
      await _authService.logout();
      emit(const AuthState.loggedOut());
    } on GenericApplicationException catch (error) {
      emit(AuthState.error(message: error.toString()));
    }
  }
}
