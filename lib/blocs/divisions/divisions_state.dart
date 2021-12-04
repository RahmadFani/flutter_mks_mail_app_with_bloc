part of 'divisions_cubit.dart';

@immutable
abstract class DivisionsState {}

class DivisionsInitial extends DivisionsState {}

class DivisionsHasData extends DivisionsState {
  final List<DivisionModel> division;

  DivisionsHasData(this.division);
}

class DivisionsEmpty extends DivisionsState {}
