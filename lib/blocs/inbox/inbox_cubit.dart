import 'package:bloc/bloc.dart';
import 'package:flutter_application_test/models/inbox_model.dart';
import 'package:flutter_application_test/repositories/letter_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'inbox_state.dart';

class InboxCubit extends Cubit<InboxState> {
  InboxCubit({required LettersRepository inboxRepository})
      : _inboxRepository = inboxRepository,
        super(InboxInitial());

  final LettersRepository _inboxRepository;

  void getInbox() async {
    try {
      final list = await _inboxRepository.getInbox();

      emit(list.isNotEmpty ? InboxHasData(list) : InboxEmpty());
    } catch (e) {
      emit(InboxEmpty());
    }
  }

  void getDraft() async {
    try {
      final list = await _inboxRepository.getDraft();

      emit(list.isNotEmpty ? InboxHasData(list) : InboxEmpty());
    } catch (e) {
      emit(InboxEmpty());
    }
  }

  void getOutbox() async {
    try {
      final list = await _inboxRepository.getOutbox();

      emit(list.isNotEmpty ? InboxHasData(list) : InboxEmpty());
    } catch (e) {
      emit(InboxEmpty());
    }
  }

  void deleteDraft(String id) async {
    try {
      await _inboxRepository.deleteInbox(id);
      getDraft();
      Get.snackbar('Berhasil', 'Pesan Draft telah terhapus.');
    } catch (e) {
      Get.snackbar('Error', 'tidak dapat menghapus inbox.');
    }
  }

  void deleteOutbox(String id) async {
    try {
      await _inboxRepository.deleteInbox(id);
      getInbox();
      Get.snackbar('Berhasil', 'Outbox telah terhapus.');
    } catch (e) {
      Get.snackbar('Error', 'tidak dapat menghapus inbox.');
    }
  }

  void deleteInbox(String id) async {
    try {
      await _inboxRepository.deleteInbox(id);
      getOutbox();
      Get.snackbar('Berhasil', 'Inbox telah terhapus.');
    } catch (e) {
      Get.snackbar('Error', 'tidak dapat menghapus inbox.');
    }
  }
}
