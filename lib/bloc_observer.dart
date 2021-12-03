// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

/// Custom [BlocObserver] that observes all bloc and cubit state changes.
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
    if (bloc is Bloc) print(change);
  }

  @override
  void onTransition(Bloc bloc, transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
