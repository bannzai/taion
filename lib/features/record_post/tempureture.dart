import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taion/features/record_post/util.dart';

class RecordPostTempureture extends StatelessWidget {
  final ValueNotifier<double?> tempureture;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  const RecordPostTempureture({
    super.key,
    required this.tempureture,
    required this.textEditingController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final tempureture = this.tempureture.value;
    if (tempureture != null) {
      if (tempureture >= 10 && tempureture < 100) {
        textEditingController.value = TextEditingValue(text: "$tempureture.");
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("体温", style: secitonTitle),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: TextFormField(
            onChanged: (text) {
              this.tempureture.value = double.parse(text.replaceAll(".", ""));
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(RegExp(r'^3.+')),
              FilteringTextInputFormatter.allow(RegExp(r'^4.+')),
            ],
            decoration: const InputDecoration(
              hintText: "36.5",
              border: OutlineInputBorder(),
            ),
            controller: textEditingController,
            maxLines: 1,
            maxLength: 4,
            keyboardType: TextInputType.number,
            focusNode: focusNode,
          ),
        ),
      ],
    );
  }
}
