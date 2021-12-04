part of 'users_cubit.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersHasData extends UsersState {
  final List<UsersModel> users;

  UsersHasData(this.users);
}

class UsersEmpty extends UsersState {}
