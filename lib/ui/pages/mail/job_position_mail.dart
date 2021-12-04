import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/divisions/divisions_cubit.dart';
import 'package:flutter_application_test/blocs/job_position/job_position_cubit.dart';

import 'package:flutter_application_test/models/division_model.dart';

import 'package:flutter_application_test/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class JobPositionMailSelectedPage extends StatefulWidget {
  const JobPositionMailSelectedPage({Key? key}) : super(key: key);

  @override
  State<JobPositionMailSelectedPage> createState() =>
      _JobPositionMailSelectedPageState();
}

class _JobPositionMailSelectedPageState
    extends State<JobPositionMailSelectedPage> {
  List<DivisionModel> selected = [];

  bool isSelected(DivisionModel division) {
    return selected.contains(division);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Posisi Kerja'),
        centerTitle: true,
        actions: [
          selected.isNotEmpty
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, selected);
                  },
                  child: Text('Pilih ${selected.length}'))
              : const SizedBox.shrink()
        ],
      ),
      body:
          BlocBuilder<JobPositionCubit, JobPositionState>(builder: (_, state) {
        if (state is JobPositionHasData) return _listUserBody(state);
        if (state is JobPositionEmpty) return const Text('Data Kosong.');
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _listUserBody(JobPositionHasData list) => ListView.builder(
      itemCount: list.division.length,
      itemBuilder: (_, index) {
        DivisionModel division = list.division[index];
        return InkWell(
          onTap: () {
            dynamic total = Get.parameters['total'] ?? '999';

            if (isSelected(division)) {
              selected.remove(division);
            } else {
              if (selected.length >= num.parse(total)) {
                return context.showErrorSnackBar(
                    message: 'Hanya bisa pilih $total users');
              }
              selected.add(division);
            }

            setState(() {});
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.person_outline,
                color: Colors.blue,
              ),
              trailing: isSelected(division)
                  ? const Icon(
                      Icons.check_outlined,
                      color: Colors.blue,
                    )
                  : null,
              title: Text(division.name),
            ),
          ),
        );
      });
}
