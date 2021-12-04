part of 'job_position_cubit.dart';

@immutable
abstract class JobPositionState {}

class JobPositionInitial extends JobPositionState {}

class JobPositionHasData extends JobPositionInitial {
  final List<DivisionModel> division;

  JobPositionHasData(this.division);
}

class JobPositionEmpty extends JobPositionInitial {}
