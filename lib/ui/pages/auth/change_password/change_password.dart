import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController username = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    username.dispose();
    oldPassword.dispose();
    newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: username,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    label: const Text('USERNAME'),
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: oldPassword,
                obscureText: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    label: const Text('OLD PASSWORD'),
                    labelStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: newPassword,
                obscureText: true,
                onEditingComplete: () => onSubmit(),
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    label: const Text('NEW PASSWORD'),
                    labelStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: onSubmit,
                        child: loading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ))),
              ),
            ],
          ),
        ));
  }

  final box = GetStorage();

  void onSubmit() async {
    if (loading) return;
    try {
      setState(() {
        loading = true;
      });

      final result =
          await post(Uri.parse(baseUrl + '/auth/change_password'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
      }, body: {
        "username": username.text,
        "old_password": oldPassword.text,
        "new_password": newPassword.text
      });
      log(result.body);

      Get.back();
      Get.snackbar('Berhasil', 'Kata sandi berhasil di ubah.');
    } catch (e) {
      Get.snackbar('Error', 'Error saat mencoba ganti password.');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
