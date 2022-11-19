import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/entity/record.codegen.dart';
import 'package:taion/features/danger/dialog.dart';
import 'package:taion/provider/record.dart';
import 'package:taion/provider/user.dart';
import 'package:taion/style/button.dart';

class RecordPostDeleteButton extends HookConsumerWidget {
  final Record record;

  const RecordPostDeleteButton({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteRecord = ref.watch(deleteRecordProvider);
    final userID = ref.watch(mustUserIDProvider);

    return DangerButton(
      text: "削除",
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => DangerDialog(
            title: "削除しますか？",
            message: "削除あとはデータが完全に消えます。削除しますか？",
            confirmationButton: AlertButton(
                onPressed: () async {
                  await deleteRecord(
                    record,
                    userID: userID,
                  );
                },
                text: "削除する"),
          ),
        );
      },
    );
  }
}
