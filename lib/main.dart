import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'bloc_observer.dart';
import 'repositories/authentication_repository.dart';

void main() async {
  await GetStorage.init();
  final authenticationRepository = AuthenticationRepository();
  BlocOverrides.runZoned(
    () => runApp(App(authenticationRepository: authenticationRepository)),
    blocObserver: AppBlocObserver(),
  );
}
