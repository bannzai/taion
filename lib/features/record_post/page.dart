import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/entity/record.codegen.dart';
import 'package:taion/features/record_post/delete_button.dart';
import 'package:taion/features/record_post/memo.dart';
import 'package:taion/features/record_post/tags.dart';
import 'package:taion/features/record_post/temperature.dart';
import 'package:taion/features/record_post/temperature_date.dart';
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
    final record = this.record;
    final setRecord = ref.watch(setRecordProvider);

    final userID = ref.watch(mustUserIDProvider);
    final temperature = useState(record?.temperature);
    final tags = useState(record?.tags ?? []);
    final memo = useState(record?.memo ?? "");
    final takeTemperatureDateTime =
        useState(record?.takeTemperatureDateTime ?? DateTime.now());
    final temperatureValue = temperature.value;
    final takeTemperatureDateTimeValue = takeTemperatureDateTime.value;

    final temperatureTextEditingController =
        useTextEditingController(text: "${temperatureValue ?? ""}");
    final memoTextEditingController =
        useTextEditingController(text: memo.value);
    final temperatureFocusNode = useFocusNode();
    final memoFocusNode = useFocusNode();

    final scrollController = useScrollController();
    final offset = MediaQuery.of(context).viewInsets.bottom;

    useEffect(() {
      if (record == null) {
        temperatureFocusNode.requestFocus();
      }
      return null;
    }, [true]);

    debugPrint("[DEBUG] Rebuild ... ${runtimeType}");

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          AppTextButton(
            text: const Text("保存"),
            onPressed: temperatureValue == null
                ? null
                : () async {
                    final record = this.record;
                    if (record != null) {
                      await setRecord(
                        record.copyWith(
                          memo: memo.value,
                          tags: tags.value,
                          takeTemperatureDateTime: takeTemperatureDateTimeValue,
                          temperature: temperatureValue,
                        ),
                        userID: userID,
                      );
                    } else {
                      await setRecord(
                        Record(
                          id: null,
                          temperature: temperatureValue,
                          tags: tags.value,
                          memo: memo.value,
                          takeTemperatureDateTime: takeTemperatureDateTimeValue,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                controller: scrollController,
                children: [
                  const SizedBox(height: 20),
                  RecordPostTempurature(
                    temperature: temperature,
                    textEditingController: temperatureTextEditingController,
                    focusNode: temperatureFocusNode,
                  ),
                  const SizedBox(height: 20),
                  RecordPostTemperatureDate(
                      temperatureDate: takeTemperatureDateTime),
                  const SizedBox(height: 20),
                  RecordPostTags(tags: tags),
                  const SizedBox(height: 20),
                  RecordPostMemo(
                    memo: memo,
                    textEditingController: memoTextEditingController,
                    focusNode: memoFocusNode,
                  ),
                  if (record != null) ...[
                    RecordPostDeleteButton(record: record)
                  ],
                  const SizedBox(height: 20),
                ],
              ),
            ),
            if (memoFocusNode.hasFocus) ...[
              _keyboardToolbar(context, memoFocusNode),
              SizedBox(height: offset),
            ],
            if (temperatureFocusNode.hasFocus) ...[
              _keyboardToolbar(context, temperatureFocusNode),
              SizedBox(height: offset),
            ],
          ],
        ),
      ),
    );
  }

  Widget _keyboardToolbar(BuildContext context, FocusNode focusNode) {
    return Container(
      height: keyboardToolbarHeight,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: AppColor.secondaryBackground),
      child: Row(
        children: [
          const Spacer(),
          AppTextButton(
            text: const Text('完了',
                style: TextStyle(
                    color: AppColor.primary, fontWeight: FontWeight.bold)),
            onPressed: () async {
              analytics.logEvent(name: "post_diary_done_button_pressed");
              focusNode.unfocus();
            },
          ),
        ],
      ),
    );
  }
}

extension RecordPostPageRoute on RecordPostPage {
  static Route<dynamic> route({required Record? record}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: "RecordPostPage"),
      builder: (_) => RecordPostPage(
        record: record,
      ),
      fullscreenDialog: true,
    );
  }
}
