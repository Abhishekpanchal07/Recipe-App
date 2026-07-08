import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/is_logged_in_use_case.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import '../../domain/usecases/params/login_params.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final IsLoggedInUseCase _isLoggedInUseCase;

  AuthBloc({
    required this._loginUseCase,
    required this._logoutUseCase,
    required this._getCurrentUserUseCase,
    required this._isLoggedInUseCase,
  }) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final user = await _loginUseCase(
        LoginParams(username: event.username, password: event.password),
      );

      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final isLoggedIn = await _isLoggedInUseCase();

    if (!isLoggedIn) {
      emit(const AuthUnauthenticated());
      return;
    }

    try {
      final user = await _getCurrentUserUseCase();

      emit(AuthAuthenticated(user: user));
    } catch (e) {
      // If server explicitly rejects the token
      if (e.toString().contains('401')) {
        await _logoutUseCase();

        emit(const AuthUnauthenticated());
        return;
      }

      // Offline / timeout / server unavailable
      emit(const AuthAuthenticated());
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutUseCase();

    emit(const AuthUnauthenticated());
  }
}
