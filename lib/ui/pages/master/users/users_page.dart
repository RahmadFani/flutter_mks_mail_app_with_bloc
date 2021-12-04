import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_application_test/blocs/users/users_cubit.dart';
import 'package:flutter_application_test/models/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'create_users_page.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () => Get.to(() => BlocProvider.value(
                  value: context.read<UsersCubit>(),
                  child: const CreateUserPage())),
              child: const Text('Create'))
        ],
      ),
      body: BlocBuilder<UsersCubit, UsersState>(builder: (_, state) {
        if (state is UsersHasData) return _listUsersBody(state, context);
        if (state is UsersEmpty) return const Text('Data Kosong.');
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _listUsersBody(UsersHasData state, BuildContext context) =>
      ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (_, index) {
            UsersModel user = state.users[index];

            bool isUser = context
                    .read<AuthenticationBloc>()
                    .state
                    .user
                    .userDetail
                    .userId ==
                user.id;

            return InkWell(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.person_outline,
                    color: Colors.blue,
                  ),
                  trailing: isUser
                      ? null
                      : IconButton(
                          onPressed: () => _hapusUser(user, context),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.blue,
                          )),
                  title: Text(user.fullname),
                  subtitle: Text(user.address),
                ),
              ),
            );
          });

  void _hapusUser(UsersModel user, BuildContext context) async {
    context.read<UsersCubit>().deleteUser(user.userId.toString());
  }
}
