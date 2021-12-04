import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/division_model.dart';
import 'package:flutter_application_test/models/inbox_model.dart';
import 'package:flutter_application_test/models/user_model.dart';
import 'package:flutter_application_test/models/users_model.dart';
import 'package:flutter_application_test/routes/app_pages.dart';
import 'package:flutter_application_test/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class ForwardInboxMaster extends StatefulWidget {
  const ForwardInboxMaster({Key? key, required this.inbox}) : super(key: key);
  final InboxModel inbox;

  @override
  _ForwardInboxMasterState createState() => _ForwardInboxMasterState();
}

class _ForwardInboxMasterState extends State<ForwardInboxMaster> {
  TextEditingController pesan = TextEditingController();

  List<dynamic> teruskanKepada = [];
  String tipeKepada = 'division/user';

  final box = GetStorage();

  void _pilihPenerima() async {
    final text = await _pilihPenerimaDialog();
    if (text == 'user') {
      final data = await Get.toNamed(
        Routes.USERS_MAIL,
      );
      if (data != null) {
        tipeKepada = 'user';
        teruskanKepada = data as List<UsersModel>;
        setState(() {});
      }
    } else if (text == 'division') {
      final data = await Get.toNamed(
        Routes.DIVISION_MAIL,
      );
      if (data != null) {
        tipeKepada = 'division';
        teruskanKepada = data as List<DivisionModel>;
        setState(() {});
      }
    }
  }

  Future _pilihPenerimaDialog({String pesan = 'Teruskan Kepada'}) async {
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

  void _prosesTeruskanPesan() async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());

      Map data = {
        'letter_id': widget.inbox.id.toString(),
        'receiver_type': tipeKepada,
        'message': pesan.text,
      };

      if (tipeKepada == 'user') {
        for (int i = 0; i < teruskanKepada.length; i++) {
          final terus = teruskanKepada[i] as UsersModel;
          data.addAll({"receivers[$i]": terus.userId.toString()});
        }
      } else if (tipeKepada == 'division') {
        for (int i = 0; i < teruskanKepada.length; i++) {
          final terus = teruskanKepada[i] as DivisionModel;
          data.addAll({"receivers[$i]": terus.id.toString()});
        }
      }
      log(tipeKepada);

      log(data.toString());
      final result = await post(
          Uri.parse(baseUrl + '/letter_disposition/disposition'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${box.read('api_token')}'
          },
          body: data);
      log(jsonDecode(result.body).toString());
      if (jsonDecode(result.body)['error_code'] == 0) {
        log(jsonDecode(result.body).toString());
        context.showSnackBar(message: 'Pesan Berhasi Diteruskan.');
        Navigator.pop(context);
      }
    } catch (e) {
      context.showErrorSnackBar(message: "Terjadi kesalahan");
      log('Error Send Mail $e');
    }
  }

  @override
  void dispose() {
    pesan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teruskan Pesan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: _pilihPenerima,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: ListTile(
                  title: Text(
                      'Teruskan Ke : ${teruskanKepada.isNotEmpty ? '${teruskanKepada.length} yang di pilih' : ''}'),
                  trailing: const Icon(Icons.add),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: pesan,
              decoration: const InputDecoration(
                  label: Text('Isi Pesan'),
                  contentPadding: EdgeInsets.only(left: 15)),
              minLines: 4,
              maxLines: 8,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _prosesTeruskanPesan,
                child: const Text('Teruskan Pesan'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
