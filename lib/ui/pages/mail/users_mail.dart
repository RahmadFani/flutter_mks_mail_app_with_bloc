import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_application_test/blocs/users/users_cubit.dart';
import 'package:flutter_application_test/models/users_model.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class UsersMailSelectPage extends StatefulWidget {
  const UsersMailSelectPage({Key? key}) : super(key: key);

  @override
  State<UsersMailSelectPage> createState() => _UsersMailSelectPageState();
}

class _UsersMailSelectPageState extends State<UsersMailSelectPage> {
  List<UsersModel> selected = [];

  bool isSelected(UsersModel user) {
    return selected.contains(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Users'),
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
      body: BlocBuilder<UsersCubit, UsersState>(builder: (_, state) {
        if (state is UsersHasData) return _listUserBody(state);
        if (state is UsersEmpty) return const Text('Data Kosong.');
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _listUserBody(UsersHasData list) => ListView.builder(
      itemCount: list.users.length,
      itemBuilder: (_, index) {
        UsersModel user = list.users[index];
        bool isUser =
            context.read<AuthenticationBloc>().state.user.userDetail.userId ==
                user.id;

        if (isUser) {
          return const SizedBox.shrink();
        }
        return InkWell(
          onTap: () {
            dynamic total = Get.parameters['total'] ?? '999';

            if (isSelected(user)) {
              selected.remove(user);
            } else {
              if (selected.length >= num.parse(total)) {
                return context.showErrorSnackBar(
                    message: 'Hanya bisa pilih $total users');
              }
              selected.add(user);
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
              trailing: isSelected(user)
                  ? const Icon(
                      Icons.check_outlined,
                      color: Colors.blue,
                    )
                  : null,
              title: Text(user.fullname),
            ),
          ),
        );
      });
}
