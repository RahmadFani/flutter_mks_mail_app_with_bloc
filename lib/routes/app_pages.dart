import 'package:flutter_application_test/blocs/divisions/divisions_cubit.dart';
import 'package:flutter_application_test/blocs/inbox/inbox_cubit.dart';
import 'package:flutter_application_test/blocs/job_position/job_position_cubit.dart';
import 'package:flutter_application_test/blocs/users/users_cubit.dart';
import 'package:flutter_application_test/repositories/letter_repository.dart';
import 'package:flutter_application_test/repositories/master_data_repository.dart';
import 'package:flutter_application_test/ui/pages/auth/change_password/change_password.dart';
import 'package:flutter_application_test/ui/pages/home/home.dart';
import 'package:flutter_application_test/ui/pages/mail/division_mail.dart';
import 'package:flutter_application_test/ui/pages/mail/draft/draft_mail.dart';
import 'package:flutter_application_test/ui/pages/mail/inbox/inbox_mail.dart';
import 'package:flutter_application_test/ui/pages/mail/job_position_mail.dart';
import 'package:flutter_application_test/ui/pages/mail/outbox/outbox_mail.dart';
import 'package:flutter_application_test/ui/pages/mail/send_mail_page.dart';
import 'package:flutter_application_test/ui/pages/mail/users_mail.dart';
import 'package:flutter_application_test/ui/pages/master/division/division_page.dart';
import 'package:flutter_application_test/ui/pages/master/job_position/job_position_page.dart';
import 'package:flutter_application_test/ui/pages/master/users/users_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.SENDING_MAIL,
      page: () => const SendMailPage(),
    ),
    GetPage(
      name: Routes.USERS_MAIL,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  UsersCubit(masterDataRepository: MasterDataRepository())
                    ..getUsers())
        ],
        child: const UsersMailSelectPage(),
      ),
    ),
    GetPage(
      name: Routes.DIVISION_MAIL,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  DivisionsCubit(masterDataRepository: MasterDataRepository())
                    ..getDivisions())
        ],
        child: const DivisionMailSelectPage(),
      ),
    ),
    GetPage(
      name: Routes.JOB_POSITION_MAIL,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  JobPositionCubit(masterDataRepository: MasterDataRepository())
                    ..getJobPosition())
        ],
        child: const JobPositionMailSelectedPage(),
      ),
    ),
    GetPage(
      name: Routes.INBOX_MAIL,
      page: () => BlocProvider(
        create: (_) =>
            InboxCubit(inboxRepository: LettersRepository())..getInbox(),
        child: const InboxMailPage(),
      ),
    ),
    GetPage(
      name: Routes.OUTBOX_MAIL,
      page: () => BlocProvider(
        create: (_) =>
            InboxCubit(inboxRepository: LettersRepository())..getOutbox(),
        child: const OutboxMailPage(),
      ),
    ),
    GetPage(
      name: Routes.DRAFT_MAIL,
      page: () => BlocProvider(
        create: (_) =>
            InboxCubit(inboxRepository: LettersRepository())..getDraft(),
        child: const DraftMailPage(),
      ),
    ),
    GetPage(
      name: Routes.CHANGE_PASSWORD,
      page: () => const ChangePasswordPage(),
    ),
    GetPage(
      name: Routes.MASTER_USER,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  UsersCubit(masterDataRepository: MasterDataRepository())
                    ..getUsers())
        ],
        child: const UsersPage(),
      ),
    ),
    GetPage(
      name: Routes.MASTER_DIVISION,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  DivisionsCubit(masterDataRepository: MasterDataRepository())
                    ..getDivisions())
        ],
        child: const DivisionsPage(),
      ),
    ),
    GetPage(
      name: Routes.MASTER_JOB_POSITIONED,
      page: () => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  JobPositionCubit(masterDataRepository: MasterDataRepository())
                    ..getJobPosition())
        ],
        child: const JobPositionPage(),
      ),
    ),
  ];
}
