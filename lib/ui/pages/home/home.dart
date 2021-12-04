import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_application_test/blocs/theme/theme_cubit.dart';
import 'package:flutter_application_test/routes/app_pages.dart';
import 'package:flutter_application_test/ui/pages/auth/login/login.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (_, state) {
      /// Cecking user if user is empty page will show [LoginPage] else [Home]
      if (state.status == AppStatus.unauthenticated) return const LoginPage();

      /// [Home]
      return Scaffold(
        appBar: AppBar(
          title: const Text('Kotak Pesan'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () => Get.toNamed(Routes.INBOX_MAIL),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 1))),
                  child: const ListTile(
                    leading: Icon(
                      Icons.inbox_outlined,
                      color: Colors.blue,
                    ),
                    trailing: Icon(Icons.chevron_right_outlined),
                    title: Text('Inbox'),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.OUTBOX_MAIL),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 1))),
                  child: const ListTile(
                    leading: Icon(
                      Icons.outbox_outlined,
                      color: Colors.blue,
                    ),
                    trailing: Icon(Icons.chevron_right_outlined),
                    title: Text('Outbox'),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.DRAFT_MAIL),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 1))),
                  child: const ListTile(
                    leading: Icon(
                      Icons.drafts_outlined,
                      color: Colors.blue,
                    ),
                    trailing: Icon(Icons.chevron_right_outlined),
                    title: Text('Draf'),
                  ),
                ),
              ),
              const ListTile(
                title: Text('MASTER DATA'),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.MASTER_USER),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 1))),
                  child: const ListTile(
                    leading: Icon(
                      Icons.people_outline_sharp,
                      color: Colors.blue,
                    ),
                    trailing: Icon(Icons.chevron_right_outlined),
                    title: Text('User'),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.MASTER_DIVISION),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 1))),
                  child: const ListTile(
                    leading: Icon(
                      Icons.account_tree_outlined,
                      color: Colors.blue,
                    ),
                    trailing: Icon(Icons.chevron_right_outlined),
                    title: Text('Division'),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.MASTER_JOB_POSITIONED),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 1))),
                  child: const ListTile(
                    leading: Icon(
                      Icons.assignment_ind_outlined,
                      color: Colors.blue,
                    ),
                    trailing: Icon(Icons.chevron_right_outlined),
                    title: Text('Job Position'),
                  ),
                ),
              ),
              const ListTile(
                title: Text('AKUN'),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 1))),
                  child: const ListTile(
                    leading: Icon(
                      Icons.password_outlined,
                      color: Colors.blue,
                    ),
                    trailing: Icon(Icons.chevron_right_outlined),
                    title: Text('Change Password'),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.withOpacity(0.5), width: 1))),
                  child: const ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colors.blue,
                    ),
                    trailing: Icon(Icons.chevron_right_outlined),
                    title: Text('Logout'),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () => Get.toNamed(Routes.SENDING_MAIL),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      );
    });
  }
}
