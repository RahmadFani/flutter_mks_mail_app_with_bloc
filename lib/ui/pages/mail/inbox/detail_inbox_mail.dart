import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/inbox_model.dart';
import 'package:get/get.dart';

import 'forward_inbox_mail.dart';

class DetailInboxMailPage extends StatelessWidget {
  const DetailInboxMailPage({Key? key, required this.inbox}) : super(key: key);

  final InboxModel inbox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(inbox.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ForwardInboxMaster(inbox: inbox));
            },
            icon: const Icon(Icons.forward),
            tooltip: 'Teruskan',
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pembuat : ${inbox.creator.fullname}',
                style: mediumFontWeight,
              ),
              Text(
                'Tanggal : ${inbox.letterDate}',
                style: mediumFontWeight,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(inbox.letterContent)
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle mediumFontWeight = const TextStyle(fontSize: 16);
