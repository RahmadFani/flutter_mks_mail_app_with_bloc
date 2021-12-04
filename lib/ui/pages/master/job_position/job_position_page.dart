import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/job_position/job_position_cubit.dart';
import 'package:flutter_application_test/models/division_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'create_job_position_page.dart';

class JobPositionPage extends StatelessWidget {
  const JobPositionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Position'),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () => Get.to(() => BlocProvider.value(
                    value: context.read<JobPositionCubit>(),
                    child: const CreateJobPositionPage(),
                  )),
              child: const Text('Create'))
        ],
      ),
      body:
          BlocBuilder<JobPositionCubit, JobPositionState>(builder: (_, state) {
        if (state is JobPositionHasData) return _listDataBody(state, context);
        if (state is JobPositionEmpty) return const Text('Data Kosong.');
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _listDataBody(JobPositionHasData state, BuildContext context) =>
      ListView.builder(
          itemCount: state.division.length,
          itemBuilder: (_, index) {
            DivisionModel division = state.division[index];

            return InkWell(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.corporate_fare,
                    color: Colors.blue,
                  ),
                  trailing: IconButton(
                      onPressed: () => _hapusData(division, context),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.blue,
                      )),
                  title: Text(division.name),
                ),
              ),
            );
          });

  void _hapusData(DivisionModel division, BuildContext context) async {
    context.read<JobPositionCubit>().deleteData(division.id.toString());
  }
}
