import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_test/models/division_model.dart';
import 'package:flutter_application_test/repositories/master_data_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'job_position_state.dart';

class JobPositionCubit extends Cubit<JobPositionState> {
  JobPositionCubit({required MasterDataRepository masterDataRepository})
      : _masterDataRepository = masterDataRepository,
        super(JobPositionInitial());

  final MasterDataRepository _masterDataRepository;

  void getJobPosition() async {
    try {
      final list = await _masterDataRepository.getJobPosition();
      log(list.length.toString());
      emit(list.isNotEmpty ? JobPositionHasData(list) : JobPositionEmpty());
    } catch (e) {
      log('error get Job Position in cubit');
      emit(JobPositionEmpty());
    }
  }

  void createJobPosition(String nama) async {
    try {
      await _masterDataRepository.createJobPosition(nama);
      getJobPosition();
      Get.back();
      Get.snackbar('Berhasil', 'Berhasil Membuat Job Position');
    } catch (e) {
      log('error get user in cubit');
      Get.snackbar('Error', 'Gagal Membuat Job Position');
    }
  }

  void deleteData(String id) async {
    try {
      await _masterDataRepository.deleteJobPosition(id);
      getJobPosition();
      Get.snackbar('Berhasil', 'Berhasil Menghapus Job Position');
    } catch (e) {
      log('error get user in cubit');
      Get.snackbar('Error', 'Gagal menghapus Job Position');
    }
  }
}
