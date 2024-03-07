import 'package:auth/data/services/auth_service.dart';
import 'package:auth/entity/user.dart';
import 'package:auth/presentation/cubit/auth_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthBase _authBase;

  AuthCubit(this._authBase) : super(const AuthState.initial());

  Future<void> signIn({
    required String email,
    required String password,
    required bool isAppClient,
  }) async {
    try {
      emit(const AuthState.loading());
      final user = await _authBase.login(email, password);
      if (user != null) {
        final authUser =
            await FirebaseFirestore.instance.doc('users/${user.uid}').get();
        final userData = AppUser.fromMap(authUser.data()!);
        emit(
          AuthState.authenticated(
              isUserInHisApp: userData.isClient == isAppClient),
        );
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
    required bool isAppClient,
  }) async {
    try {
      emit(const AuthState.loading());
      final user = await _authBase.register(email, password);
      if (user != null) {
        await FirebaseFirestore.instance.doc('users/${user.uid}').set(
              AppUser(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                isClient: isAppClient,
              ).toMap(),
            );
        emit(
          const AuthState.authenticated(isUserInHisApp: true),
        );
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
