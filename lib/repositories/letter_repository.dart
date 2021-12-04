import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_application_test/models/inbox_model.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class LettersRepository {
  final box = GetStorage();

  /// {@Inbox}
  Future<List<InboxModel>> getInbox() async {
    try {
      log(box.read('api_token'));
      final result = await get(Uri.parse(baseUrl + '/letter/inbox'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
      });

      if (result.statusCode == 200) {
        List listJson = jsonDecode(result.body);
        List<InboxModel> list =
            listJson.map((e) => InboxModel.fromJson(e)).toList();

        return list;
      } else {
        throw 'Error';
      }
    } catch (e) {
      log('Error $e');
      throw Exception(e);
    }
  }

  Future<void> deleteInbox(String ids) async {
    try {
      final result = await get(Uri.parse(baseUrl + '/letter/delete/$ids'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
          });
      log(result.body);
    } catch (e) {
      log('Error $e');
      throw Exception(e);
    }
  }

  /// {@endInbox}

  /// {@OUTBOX}
  Future<List<InboxModel>> getOutbox() async {
    try {
      log(box.read('api_token'));
      final result = await get(Uri.parse(baseUrl + '/letter/outbox'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
      });
      log(result.body);
      if (result.statusCode == 200) {
        List listJson = jsonDecode(result.body);

        List<InboxModel> list =
            listJson.map((e) => InboxModel.fromJson(e)).toList();

        log(list.length.toString());

        return list;
      } else {
        throw 'Error';
      }
    } catch (e) {
      log('Error $e');
      throw Exception(e);
    }
  }

  /// {@ENDOUTBOX}

  Future<List<InboxModel>> getDraft() async {
    try {
      log(box.read('api_token'));
      final result = await get(Uri.parse(baseUrl + '/letter/draft'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
      });
      log(result.body);
      if (result.statusCode == 200) {
        List listJson = jsonDecode(result.body);

        List<InboxModel> list =
            listJson.map((e) => InboxModel.fromJson(e)).toList();

        log(list.length.toString());

        return list;
      } else {
        throw 'Error';
      }
    } catch (e) {
      log('Error $e');
      throw Exception(e);
    }
  }
}
