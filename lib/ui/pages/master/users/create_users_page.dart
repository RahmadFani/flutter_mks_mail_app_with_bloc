import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/users/users_cubit.dart';
import 'package:flutter_application_test/models/division_model.dart';
import 'package:flutter_application_test/routes/app_pages.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController alamatLahir = TextEditingController();
  TextEditingController tanggalLahir = TextEditingController();

  DivisionModel? divisi;
  DivisionModel? position;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    email.dispose();
    namaLengkap.dispose();
    alamat.dispose();
    alamatLahir.dispose();
    tanggalLahir.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BUAT USER'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: username,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    label: const Text('NAMA PENGGUNA'),
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: password,
                obscureText: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    label: const Text('KATA SANDI'),
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
                controller: email,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    label: const Text('EMAIL'),
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: namaLengkap,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    label: const Text('NAMA LENGKAP'),
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: alamat,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.alt_route_outlined,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    label: const Text('ALAMAT'),
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: alamatLahir,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.alt_route,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    label: const Text('ALAMAT LAHIR'),
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: tanggalLahir,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.view_day,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    label: const Text('TANGGAL LAHIR'),
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final result = await Get.toNamed(Routes.DIVISION_MAIL,
                      parameters: {'total': '1'});

                  if (result is List<DivisionModel>) {
                    divisi = result[0];
                    setState(() {});
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: ListTile(
                    title: Text(
                        'DIVISI : ${divisi != null ? '${divisi!.name} ' : ''}'),
                    trailing: const Icon(Icons.add),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final result = await Get.toNamed(Routes.JOB_POSITION_MAIL,
                      parameters: {'total': '1'});

                  if (result is List<DivisionModel>) {
                    position = result[0];
                    setState(() {});
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: ListTile(
                    title: Text(
                        'POSISI KERJA : ${position != null ? '${position!.name} ' : ''}'),
                    trailing: const Icon(Icons.add),
                  ),
                ),
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
                        onPressed: () async {
                          try {
                            final box = GetStorage();
                            final result = await post(
                                Uri.parse(baseUrl + '/master/user/save'),
                                headers: {
                                  HttpHeaders.authorizationHeader:
                                      'Bearer ${box.read('api_token')}'
                                },
                                body: {
                                  'username': username.text,
                                  'password': password.text,
                                  'email': email.text,
                                  'fullname': namaLengkap.text,
                                  'address': alamat.text,
                                  'pob': alamatLahir.text,
                                  'dob': tanggalLahir.text,
                                  'division': divisi?.id.toString() ?? '0',
                                  'job_position':
                                      position?.id.toString() ?? '0',
                                });
                            log(result.body);
                            context.read<UsersCubit>().getUsers();
                            Get.back();
                          } catch (e) {
                            Get.snackbar('Gagal', 'User Gagal Dibuat');
                          }
                        },
                        child: const Text(
                          'BUAT',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
