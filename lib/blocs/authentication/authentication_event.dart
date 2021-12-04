part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationChanged extends AuthenticationEvent {
  final UserModel user;

  AuthenticationChanged(this.user);
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
