import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/divisions/divisions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDivisionPage extends StatefulWidget {
  const CreateDivisionPage({Key? key}) : super(key: key);

  @override
  _CreateDivisionPageState createState() => _CreateDivisionPageState();
}

class _CreateDivisionPageState extends State<CreateDivisionPage> {
  TextEditingController namaDivision = TextEditingController();

  @override
  void dispose() {
    namaDivision.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Division'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: namaDivision,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.corporate_fare,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  label: const Text('NAMA DIVISION'),
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey))),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<DivisionsCubit>()
                            .createDivision(namaDivision.text);
                      },
                      child: const Text(
                        'BUAT DIVISI',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
