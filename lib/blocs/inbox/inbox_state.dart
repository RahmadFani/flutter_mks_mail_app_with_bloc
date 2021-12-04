part of 'inbox_cubit.dart';

@immutable
abstract class InboxState {}

class InboxInitial extends InboxState {}

class InboxHasData extends InboxInitial {
  final List<InboxModel> inbox;

  InboxHasData(this.inbox);
}

class InboxEmpty extends InboxInitial {}
