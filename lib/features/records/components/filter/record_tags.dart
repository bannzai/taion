import 'package:flutter/material.dart';
import 'package:taion/entity/record.codegen.dart';
import 'package:taion/style/color.dart';

class RecordsFilterRecordTags extends StatelessWidget {
  final ValueNotifier<List<String>> selectedTags;

  const RecordsFilterRecordTags({super.key, required this.selectedTags});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("タグ",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 17,
              color: AppColor.textMain,
            )),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: defaultTags.map((e) {
            isSelected() => selectedTags.value.contains(e);
            return ChoiceChip(
              label: Text(e),
              labelStyle:
                  TextStyle(color: isSelected() ? Colors.white : Colors.grey),
              disabledColor: AppColor.secondaryBackground,
              selectedColor: AppColor.primary,
              selected: isSelected(),
              onSelected: (selected) {
                if (isSelected()) {
                  selectedTags.value = List.from(selectedTags.value)..remove(e);
                } else {
                  selectedTags.value = List.from(selectedTags.value)..add(e);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
