part of 'authentication_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

@immutable
class AuthenticationState {
  const AuthenticationState._({required this.status, required this.user});

  const AuthenticationState.authenticated(UserModel user)
      : this._(status: AppStatus.authenticated, user: user);

  AuthenticationState.unauthenticated()
      : this._(status: AppStatus.unauthenticated, user: UserModel.empty);

  final AppStatus status;
  final UserModel user;
}
