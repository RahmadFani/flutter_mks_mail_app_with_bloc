// ignore_for_file: constant_identifier_names

part of './app_pages.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const CHANGE_PASSWORD = '/change_password';
  static const SENDING_MAIL = '/mail/sending';
  static const USERS_MAIL = '/mail/users';
  static const DIVISION_MAIL = '/mail/division';
  static const JOB_POSITION_MAIL = '/mail/job_positioned';
  static const INBOX_MAIL = '/mail/inbox';
  static const OUTBOX_MAIL = '/mail/outbox';
  static const DRAFT_MAIL = '/mail/draft';

  /// Master Data
  static const MASTER_USER = '/master/users';
  static const MASTER_DIVISION = '/master/division';
  static const MASTER_JOB_POSITIONED = '/master/job_positioned';
}
