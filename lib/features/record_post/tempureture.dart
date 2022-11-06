import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taion/features/record_post/util.dart';

class RecordPostTempureture extends StatelessWidget {
  final ValueNotifier<double?> tempertureture;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  const RecordPostTempureture({
    super.key,
    required this.tempertureture,
    required this.textEditingController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("体温", style: secitonTitle),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: (text) {
            debugPrint("[DEBUG] $text");
            if (text.isEmpty) {
              tempertureture.value = null;
              return;
            }
            tempertureture.value = double.parse(text.replaceAll(".", ""));
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            TempertureInputFormatter(),
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
      ],
    );
  }
}

class TempertureInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (oldValue.text.contains(".")) {
      if (newValue.text.length >= 4) {
        // e.g) Old: 36.5, New: 3655, Result: 36.5
        return oldValue;
      }
      if (oldValue.text.length == newValue.text.length &&
          oldValue.text.length == 3) {
        // e.g) Old: 36., New: 365, Result: 36.5
        return TextEditingValue(
          text:
              "${newValue.text.substring(0, 2)}.${newValue.text.substring(2, 3)}",
          selection: TextSelection.collapsed(
              offset: newValue.selection.baseOffset + 1),
          composing: TextRange.empty,
        );
      }
    }

    if (oldValue.text.length < newValue.text.length) {
      if (oldValue.text.isEmpty && newValue.text.length == 1) {
        // e.g) Old: , New: 3, Result: 3
        return newValue;
      }
      if (oldValue.text.length == 1 && newValue.text.length == 2) {
        // e.g) Old: 3, New: 36, Result: 36.
        return TextEditingValue(
          text: "${newValue.text}.",
          selection: TextSelection.collapsed(
              offset: newValue.selection.baseOffset + 1),
          composing: TextRange.empty,
        );
      }
      if (oldValue.text.length == 2 && newValue.text.length == 3) {
        // e.g) Old: 36, New: 365, Result: 36.5
        return TextEditingValue(
          text:
              "${newValue.text.substring(0, 2)}.${newValue.text.substring(2, 3)}",
          selection: TextSelection.collapsed(
              offset: newValue.selection.baseOffset + 1),
          composing: TextRange.empty,
        );
      }
      if (oldValue.text.length == 3 && newValue.text.length == 4) {
        assert(false, "unexpected pattern ${oldValue.text}, ${newValue.text}");
        return newValue;
      }
    } else if (oldValue.text.length > newValue.text.length) {
      // e.g) Old: 36.5, New: 36., Result: 36.
      // e.g) Old: 36., New: 36, Result: 36
      // e.g) Old: 36, New: 3, Result: 3
      // e.g) Old: 3, New: , Result:
      return newValue;
    }

    return newValue;
  }
}
