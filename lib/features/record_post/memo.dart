import 'package:flutter/material.dart';

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
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        maxWidth: MediaQuery.of(context).size.width,
        minHeight: 40,
        maxHeight: 200,
      ),
      child: TextFormField(
        onChanged: (text) {
          memo.value = text;
        },
        decoration: const InputDecoration(
          hintText: "メモ",
          border: OutlineInputBorder(),
        ),
        controller: textEditingController,
        maxLines: null,
        maxLength: textLength,
        keyboardType: TextInputType.multiline,
        focusNode: focusNode,
      ),
    );
  }
}
