import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_application_test/models/division_model.dart';
import 'package:flutter_application_test/models/users_model.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' show get, post;

/// {@template MasterDataRepository}
/// A repository for Mater data include user, division, job position
/// {@endtemplate}
class MasterDataRepository {
  final box = GetStorage();

  /// {USER}

  Future<List<UsersModel>> getUsers() async {
    try {
      final result = await get(Uri.parse(baseUrl + '/master/user'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
      });

      if (result.statusCode == 200) {
        log(result.body.toString());
        List listJson = jsonDecode(result.body);
        List<UsersModel> list =
            listJson.map((e) => UsersModel.fromJson(e)).toList();

        return list;
      } else {
        throw 'Error';
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      final result = await get(Uri.parse(baseUrl + '/master/user/delete/$id'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
          });
      log(result.body);
    } catch (e) {
      log('Error $e');
      throw Exception(e);
    }
  }

  /// {END USER}

  /// {Division}

  Future<List<DivisionModel>> getDivisions() async {
    try {
      final result = await get(Uri.parse(baseUrl + '/master/division'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
          });

      if (result.statusCode == 200) {
        log(result.body.toString());
        List listJson = jsonDecode(result.body);
        List<DivisionModel> list =
            listJson.map((e) => DivisionModel.fromJson(e)).toList();

        return list;
      } else {
        throw 'Error';
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<void> createDivision(String nama) async {
    try {
      final result = await post(Uri.parse(baseUrl + '/master/division/save'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
          },
          body: {
            'name': nama
          });
      log(result.body);
      if (result.statusCode == 404) throw Error();
    } catch (e) {
      log('Error $e');
      throw Exception(e);
    }
  }

  Future<void> deleteDivision(String id) async {
    try {
      final result = await get(
          Uri.parse(baseUrl + '/master/division/delete/$id'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
          });
      if (result.statusCode == 404) throw Error();
    } catch (e) {
      log('Error $e');
      throw Exception(e);
    }
  }

  /// {END Division}

  /// {JobPosition}

  Future<List<DivisionModel>> getJobPosition() async {
    try {
      final result = await get(Uri.parse(baseUrl + '/master/job_position'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
          });

      if (result.statusCode == 200) {
        log(result.body.toString());
        List listJson = jsonDecode(result.body);
        List<DivisionModel> list =
            listJson.map((e) => DivisionModel.fromJson(e)).toList();

        return list;
      } else {
        throw 'Error';
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<void> createJobPosition(String nama) async {
    try {
      final result = await post(
          Uri.parse(baseUrl + '/master/job_position/save'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
          },
          body: {
            'name': nama
          });
      log(result.body);
      if (result.statusCode == 404) throw Error();
    } catch (e) {
      log('Error $e');
      throw Exception(e);
    }
  }

  Future<void> deleteJobPosition(String id) async {
    try {
      final result = await get(
          Uri.parse(baseUrl + '/master/job_position/delete/$id'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
          });
      if (result.statusCode == 404) throw Error();
    } catch (e) {
      log('Error $e');
      throw Exception(e);
    }
  }

  /// {END JobPosition}
}
