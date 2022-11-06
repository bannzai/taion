import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/entity/record.codegen.dart';
import 'package:taion/features/record_post/memo.dart';
import 'package:taion/features/record_post/tags.dart';
import 'package:taion/features/record_post/tempureture.dart';
import 'package:taion/provider/record.dart';
import 'package:taion/provider/user.dart';
import 'package:taion/style/button.dart';
import 'package:taion/style/color.dart';
import 'package:taion/utility/analytics.dart';
import 'package:taion/utility/const.dart';

class RecordPostPage extends HookConsumerWidget {
  final Record? record;

  const RecordPostPage({super.key, required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userID = ref.watch(mustUserIDProvider);
    final setRecord = ref.watch(setRecordProvider);
    final tempureture = useState(record?.temperature);
    final tags = useState(record?.tags ?? []);
    final memo = useState(record?.memo ?? "");
    final takeTempertureDateTime = useState(record?.takeTempertureDateTime);
    final tempuretureValue = tempureture.value;
    final takeTempertureDateTimeValue = takeTempertureDateTime.value;

    final tempuretureTextEditingController =
        useTextEditingController(text: memo.value);
    final tempuretureFocusNode = useFocusNode();
    final memoTextEditingController =
        useTextEditingController(text: memo.value);
    final memoFocusNode = useFocusNode();

    final scrollController = useScrollController();
    final offset =
        MediaQuery.of(context).viewInsets.bottom + keyboardToolbarHeight + 60;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          AppTextButton(
            text: const Text("保存", style: TextStyle(color: AppColor.primary)),
            onPressed: tempuretureValue == null ||
                    takeTempertureDateTimeValue == null
                ? null
                : () async {
                    final record = this.record;
                    if (record != null) {
                      await setRecord(
                        record.copyWith(
                          memo: memo.value,
                          tags: tags.value,
                          takeTempertureDateTime: takeTempertureDateTimeValue,
                          temperature: tempuretureValue,
                        ),
                        userID: userID,
                      );
                    } else {
                      await setRecord(
                        Record(
                          id: null,
                          temperature: tempuretureValue,
                          tags: tags.value,
                          memo: memo.value,
                          takeTempertureDateTime: takeTempertureDateTimeValue,
                          createdDateTime: DateTime.now(),
                        ),
                        userID: userID,
                      );
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, offset),
              child: ListView(
                controller: scrollController,
                children: [
                  RecordPostTempureture(
                    tempureture: tempureture,
                    textEditingController: tempuretureTextEditingController,
                    focusNode: tempuretureFocusNode,
                  ),
                  const SizedBox(height: 20),
                  RecordPostTags(tags: tags),
                  const SizedBox(height: 20),
                  RecordPostMemo(
                    memo: memo,
                    textEditingController: memoTextEditingController,
                    focusNode: memoFocusNode,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            if (memoFocusNode.hasFocus)
              _keyboardToolbar(context, memoFocusNode),
          ],
        ),
      ),
    );
  }

  Widget _keyboardToolbar(BuildContext context, FocusNode focusNode) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      child: Container(
        height: keyboardToolbarHeight,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            const Spacer(),
            AppTextButton(
              text: const Text('完了', style: TextStyle(color: AppColor.primary)),
              onPressed: () async {
                analytics.logEvent(name: "post_diary_done_button_pressed");
                focusNode.unfocus();
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension RecordPostPageRoute on RecordPostPage {
  static Route<dynamic> route({required Record record}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: "DiaryPostPage"),
      builder: (_) => RecordPostPage(
        record: record,
      ),
      fullscreenDialog: true,
    );
  }
}
