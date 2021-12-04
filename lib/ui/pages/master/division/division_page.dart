import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/divisions/divisions_cubit.dart';
import 'package:flutter_application_test/models/division_model.dart';
import 'package:flutter_application_test/ui/pages/master/division/create_division_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DivisionsPage extends StatelessWidget {
  const DivisionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divisions'),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () => Get.to(() => BlocProvider.value(
                    value: context.read<DivisionsCubit>(),
                    child: const CreateDivisionPage(),
                  )),
              child: const Text('Create'))
        ],
      ),
      body: BlocBuilder<DivisionsCubit, DivisionsState>(builder: (_, state) {
        if (state is DivisionsHasData) return _listDataBody(state, context);
        if (state is DivisionsEmpty) return const Text('Data Kosong.');
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _listDataBody(DivisionsHasData state, BuildContext context) =>
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
    context.read<DivisionsCubit>().deleteData(division.id.toString());
  }
}
