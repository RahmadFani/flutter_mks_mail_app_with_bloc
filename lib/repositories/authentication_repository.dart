import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_test/models/user_model.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' show post;

/// {@template AuthenticationRepository}
/// A repository for authentication
/// {@endtemplate}
class AuthenticationRepository {
  final StreamController<UserModel> _controller = StreamController<UserModel>();
  final box = GetStorage();
  Stream<UserModel> get user async* {
    yield* _controller.stream;
  }

  Future<void> login(
      {required String username, required String password}) async {
    try {
      final result = await post(Uri.parse(baseUrl + '/auth/login'),
          body: {'username': username, 'password': password});
      Get.log(username);
      Get.log(password);
      if (result.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(result.body));
        box.write('api_token', user.apiToken);
        _controller.add(user);
      } else {
        Get.log('Error Status : ${result.statusCode} ');
        throw 'Error';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> ping() async {
    try {
      final result = await post(
        Uri.parse(baseUrl + '/auth/ping'),
      );
      if (result.statusCode == 201) {
        box.write('api_token', jsonDecode(result.body)['api_token']);
        return jsonDecode(result.body)['api_token'];
      } else {
        throw 'Error';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    box.remove('api_token');
  }

  Future<void> changePassword(
      {required String username,
      required String oldPassword,
      required newPassword}) async {
    try {
      await post(Uri.parse(baseUrl + '/auth/login'), body: {
        'username': username,
        'old_password': oldPassword,
        'new_password': newPassword
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
