import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/job_position/job_position_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateJobPositionPage extends StatefulWidget {
  const CreateJobPositionPage({Key? key}) : super(key: key);

  @override
  _CreateJobPositionPageState createState() => _CreateJobPositionPageState();
}

class _CreateJobPositionPageState extends State<CreateJobPositionPage> {
  TextEditingController namaJobPosition = TextEditingController();

  @override
  void dispose() {
    namaJobPosition.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POSISI PEKERJAAN'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: namaJobPosition,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.corporate_fare,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  label: const Text('POSISI PEKERJAAN'),
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
                            .read<JobPositionCubit>()
                            .createJobPosition(namaJobPosition.text);
                      },
                      child: const Text(
                        'BUAT',
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
