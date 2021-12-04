import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_test/models/user_model.dart';
import 'package:flutter_application_test/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AuthenticationState.unauthenticated()) {
    on<AuthenticationChanged>(_onUserChanged);
    on<AuthenticationLogoutRequested>(_onUserLogoutRequested);
    _userSubscription = _authenticationRepository.user
        .listen((UserModel user) => add(AuthenticationChanged(user)));
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription _userSubscription;

  void _onUserChanged(AuthenticationChanged event, Emitter emit) {
    emit(event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : AuthenticationState.unauthenticated());
  }

  void _onUserLogoutRequested(
      AuthenticationLogoutRequested event, Emitter emit) {
    unawaited(_authenticationRepository.logout());
    emit(AuthenticationState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
