import 'package:flutter/material.dart';
import 'package:flutter_application_test/blocs/inbox/inbox_cubit.dart';
import 'package:flutter_application_test/models/inbox_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DraftMailPage extends StatelessWidget {
  const DraftMailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draft Pesan'),
        centerTitle: true,
      ),
      body: BlocBuilder<InboxCubit, InboxState>(builder: (_, state) {
        if (state is InboxHasData) return _listInboxBody(state, context);
        if (state is InboxEmpty) return const Text('Data Kosong.');
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _listInboxBody(InboxHasData state, BuildContext context) =>
      ListView.builder(
          itemCount: state.inbox.length,
          itemBuilder: (_, index) {
            InboxModel inbox = state.inbox[index];
            return InkWell(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.mail_outline,
                    color: Colors.blue,
                  ),
                  trailing: IconButton(
                      onPressed: () => _hapusSurat(inbox, context),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.blue,
                      )),
                  title: Text(inbox.title),
                  subtitle: Text(inbox.letterContent),
                ),
              ),
            );
          });

  void _hapusSurat(InboxModel inbox, BuildContext context) async {
    context.read<InboxCubit>().deleteDraft(inbox.id.toString());
  }
}
