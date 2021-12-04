import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_test/models/division_model.dart';
import 'package:flutter_application_test/repositories/master_data_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'divisions_state.dart';

class DivisionsCubit extends Cubit<DivisionsState> {
  DivisionsCubit({required MasterDataRepository masterDataRepository})
      : _masterDataRepository = masterDataRepository,
        super(DivisionsInitial());

  final MasterDataRepository _masterDataRepository;

  void getDivisions() async {
    try {
      final list = await _masterDataRepository.getDivisions();
      log(list.length.toString());
      emit(list.isNotEmpty ? DivisionsHasData(list) : DivisionsEmpty());
    } catch (e) {
      log('error get division in cubit');
      emit(DivisionsEmpty());
    }
  }

  void createDivision(String nama) async {
    try {
      await _masterDataRepository.createDivision(nama);
      getDivisions();
      Get.back();
      Get.snackbar('Berhasil', 'Berhasil Membuat Divisi');
    } catch (e) {
      log('error get user in cubit');
      Get.snackbar('Error', 'Gagal Membuat Divisi');
    }
  }

  void deleteData(String id) async {
    try {
      await _masterDataRepository.deleteDivision(id);
      getDivisions();
      Get.snackbar('Berhasil', 'Berhasil Menghapus Division');
    } catch (e) {
      log('error get user in cubit');
      Get.snackbar('Error', 'Gagal menghapus Division');
    }
  }
}
