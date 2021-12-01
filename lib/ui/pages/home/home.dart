import 'package:flutter/material.dart';
import 'package:flutter_application_test/utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Starter Flutter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.showErrorSnackBar(message: 'Extension');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
