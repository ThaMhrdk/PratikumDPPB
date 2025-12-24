part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  const AuthState({required this.status, this.user, this.message});

  const AuthState.initial()
    : status = AuthStatus.initial,
      user = null,
      message = null;

  final AuthStatus status;
  final UserModel? user;
  final String? message;

  AuthState copyWith({AuthStatus? status, UserModel? user, String? message}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, user, message];
}
