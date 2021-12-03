import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'blocs/theme/theme_cubit.dart';
import 'routes/app_pages.dart';

/// {@template app}
/// A [StatelessWidget] that:
/// * uses [bloc](https://pub.dev/packages/bloc) and
/// [flutter_bloc](https://pub.dev/packages/flutter_bloc)
/// to manage the state
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const AppView(),
    );
  }
}

/// {@template app_view}
/// A [StatelessWidget] that:
/// * reacts to state changes in the [ThemeCubit]
/// and updates the theme of the [GetMaterialApp].
/// {@endtemplate}
class AppView extends StatelessWidget {
  /// {@macro app_view}
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(builder: (_, theme) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        theme: theme,
        initialRoute: Routes.HOME,
        getPages: AppPages.pages,
      );
    });
  }
}
