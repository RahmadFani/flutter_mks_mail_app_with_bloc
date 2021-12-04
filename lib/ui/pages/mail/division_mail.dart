import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/divisions/divisions_cubit.dart';

import 'package:flutter_application_test/models/division_model.dart';

import 'package:flutter_application_test/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DivisionMailSelectPage extends StatefulWidget {
  const DivisionMailSelectPage({Key? key}) : super(key: key);

  @override
  State<DivisionMailSelectPage> createState() => _DivisionMailSelectPageState();
}

class _DivisionMailSelectPageState extends State<DivisionMailSelectPage> {
  List<DivisionModel> selected = [];

  bool isSelected(DivisionModel division) {
    return selected.contains(division);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Division'),
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
      body: BlocBuilder<DivisionsCubit, DivisionsState>(builder: (_, state) {
        if (state is DivisionsHasData) return _listUserBody(state);
        if (state is DivisionsEmpty) return const Text('Data Kosong.');
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _listUserBody(DivisionsHasData list) => ListView.builder(
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
