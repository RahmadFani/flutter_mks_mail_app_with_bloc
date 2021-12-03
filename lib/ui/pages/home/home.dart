import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/theme/theme_cubit.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Starter Flutter bloc and getx'),
        ),
        floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  context.showErrorSnackBar(message: 'Extension');
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 4),
              FloatingActionButton(
                child: const Icon(Icons.brightness_6),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              ),
            ]));
  }
}
