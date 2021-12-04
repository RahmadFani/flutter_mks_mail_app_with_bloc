import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_test/models/users_model.dart';
import 'package:flutter_application_test/repositories/master_data_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit({required MasterDataRepository masterDataRepository})
      : _masterDataRepository = masterDataRepository,
        super(UsersInitial());

  final MasterDataRepository _masterDataRepository;

  void getUsers() async {
    try {
      final list = await _masterDataRepository.getUsers();
      log(list.length.toString());
      emit(list.isNotEmpty ? UsersHasData(list) : UsersEmpty());
    } catch (e) {
      log('error get user in cubit');
      emit(UsersEmpty());
    }
  }

  void deleteUser(String id) async {
    try {
      await _masterDataRepository.deleteUser(id);
      getUsers();
      Get.snackbar('Berhasil', 'Berhasil Menghapus user');
    } catch (e) {
      log('error get user in cubit');
      Get.snackbar('Error', 'Gagal menghapus user');
    }
  }
}
