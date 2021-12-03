

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc_observer.dart';

void main() {
 BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: AppBlocObserver(),
  );
}
