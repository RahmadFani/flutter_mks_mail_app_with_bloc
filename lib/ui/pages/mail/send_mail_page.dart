import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_application_test/models/division_model.dart';
import 'package:flutter_application_test/models/users_model.dart';
import 'package:flutter_application_test/routes/app_pages.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class SendMailPage extends StatefulWidget {
  const SendMailPage({Key? key}) : super(key: key);

  @override
  _SendMailPageState createState() => _SendMailPageState();
}

class _SendMailPageState extends State<SendMailPage> {
  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();

  String tipeKepada = '';
  String tipeSebagai = '';
  dynamic kepada;
  String send = '0';

  final box = GetStorage();

  String get textKepada {
    if (kepada == null) {
      return '';
    }
    if (kepada is UsersModel) {
      UsersModel text = kepada as UsersModel;
      return text.fullname;
    } else {
      DivisionModel text = kepada as DivisionModel;
      return text.name;
    }
  }

  String get idKepada {
    if (kepada == null) {
      return '';
    }
    if (kepada is UsersModel) {
      UsersModel text = kepada as UsersModel;
      return text.id.toString();
    } else {
      DivisionModel text = kepada as DivisionModel;
      return text.id.toString();
    }
  }

  List<UsersModel> listCC = [];

  void _pilihPenerima() async {
    final text = await _pilihPenerimaDialog();
    if (text == 'user') {
      final data =
          await Get.toNamed(Routes.USERS_MAIL, parameters: {'total': '1'});
      if (data != null) {
        tipeKepada = 'to_user';
        kepada = data[0] as UsersModel;
        setState(() {});
      }
    } else if (text == 'division') {
      final data =
          await Get.toNamed(Routes.DIVISION_MAIL, parameters: {'total': '1'});
      if (data != null) {
        tipeKepada = 'to_division';
        kepada = data[0] as DivisionModel;
        setState(() {});
      }
    }
  }

  void _pilihCC() async {
    final data = await Get.toNamed(
      Routes.USERS_MAIL,
    );
    if (data != null) {
      listCC.clear();
      listCC.addAll(data);
      setState(() {});
    }
  }

  Future _pilihPenerimaDialog({String pesan = 'Kirim Ke'}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(pesan),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context, 'user');
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: const ListTile(
                      title: Text('User'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, 'division');
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: const ListTile(
                      title: Text('Division'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _kirimPesan() async {
    FocusScope.of(context).requestFocus(FocusNode());
    final text = await _pilihPenerimaDialog(pesan: 'Kirim Sebagai');
    if (text != null) {
      if (text == 'user') {
        tipeSebagai = 'from_user';
      } else {
        tipeSebagai = 'from_division';
      }

      final sending = await _lanjutKirimPesan();
      if (sending != null) {
        send = sending;
        setState(() {});
        _prosesKirimPesan();
      }
    }
  }

  Future _lanjutKirimPesan() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ingin lanjut memperoses kirim pesan ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context, '1');
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: const ListTile(
                      title: Text('Iya'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, '0');
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: const ListTile(
                      title: Text('Tidak'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _prosesKirimPesan() async {
    String sebagai = '';

    if (tipeSebagai == 'from_user') {
      sebagai = context
          .read<AuthenticationBloc>()
          .state
          .user
          .userDetail
          .userId
          .toString();
    } else {
      sebagai = context
          .read<AuthenticationBloc>()
          .state
          .user
          .userDetail
          .divisionId
          .toString();
    }

    log(sebagai);
    log(idKepada);

    Map data = {
      'title': judul.text,
      'date': DateTime.now().year.toString() +
          '-' +
          DateTime.now().month.toString() +
          '-' +
          DateTime.now().day.toString(),
      'letter_content': isi.text,
      tipeSebagai: sebagai,
      tipeKepada: idKepada,
      'send': send,
    };

    for (int i = 0; i < listCC.length; i++) {
      data.addAll({"cc_users[$i]": listCC[i].userId.toString()});
    }

    log(data.toString());

    try {
      final result = await post(Uri.parse(baseUrl + '/letter/save'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
          },
          body: data);
      if (jsonDecode(result.body)['error_code'] == 0) {
        context.showSnackBar(message: 'Mail berhasil tersimpan.');
        Navigator.pop(context);
      }
    } catch (e) {
      context.showErrorSnackBar(message: "Terjadi kesalahan");
      log('Error Send Mail $e');
    }
  }

  @override
  void dispose() {
    judul.dispose();
    isi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan Baru'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: judul,
                decoration: const InputDecoration(label: Text('Judul')),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: _pilihPenerima,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: ListTile(
                    title: Text('Kepada : $textKepada'),
                    trailing: const Icon(Icons.add),
                  ),
                ),
              ),
              InkWell(
                onTap: _pilihCC,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: ListTile(
                    title: Text(
                        'CC : ${listCC.isNotEmpty ? '${listCC.length} data terpilih' : ''}'),
                    trailing: const Icon(Icons.add),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: isi,
                decoration: const InputDecoration(label: Text('Isi Pesan')),
                minLines: 4,
                maxLines: 8,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _kirimPesan,
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}
