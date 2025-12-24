import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/auth_repository.dart';
import '../data/auth_storage.dart';
import '../data/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required AuthStorage authStorage,
  }) : _authRepository = authRepository,
       _authStorage = authStorage,
       super(const AuthState.initial()) {
    on<AuthCheckRequested>(_onCheckRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthProfileRequested>(_onProfileRequested);
  }

  final AuthRepository _authRepository;
  final AuthStorage _authStorage;

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final hasToken = await _authStorage.hasToken();
      if (hasToken) {
        final user = await _authRepository.getProfile();
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      } else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await _authRepository.login(
        email: event.email,
        password: event.password,
      );
      final user = result['user'] as UserModel;
      final token = result['token'] as String;

      await _authStorage.saveToken(token);
      await _authStorage.saveUser(
        id: user.id,
        name: user.name,
        email: user.email,
      );

      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          message: result['message'] as String,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final result = await _authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      );

      final user = result['user'] as UserModel;
      final token = result['token'] as String;

      await _authStorage.saveToken(token);
      await _authStorage.saveUser(
        id: user.id,
        name: user.name,
        email: user.email,
      );

      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          message: result['message'] as String,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.logout();
      await _authStorage.clearAll();
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          message: 'Logout berhasil',
        ),
      );
    } catch (e) {
      await _authStorage.clearAll();
      emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onProfileRequested(
    AuthProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final user = await _authRepository.getProfile();
      emit(state.copyWith(user: user));
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }
}
