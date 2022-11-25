import 'package:flutter/material.dart';
import 'package:taion/style/color.dart';
import 'package:taion/utility/random.dart';

class RecordPostMemo extends StatelessWidget {
  final ValueNotifier<String> memo;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  const RecordPostMemo({
    super.key,
    required this.memo,
    required this.textEditingController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    const textLength = 120;
    final hintText = pickRandomElement<String>([
      "酒を飲みすぎた",
      "食べすぎた",
      "歌いすぎた",
      "寒中水泳やりすぎた",
    ]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("メモ",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 17,
              color: AppColor.textMain,
            )),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            maxWidth: MediaQuery.of(context).size.width,
            minHeight: 80,
            maxHeight: 200,
          ),
          child: TextFormField(
            onChanged: (text) {
              memo.value = text;
            },
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(),
            ),
            controller: textEditingController,
            maxLines: null,
            maxLength: textLength,
            keyboardType: TextInputType.multiline,
            focusNode: focusNode,
          ),
        ),
      ],
    );
  }
}
