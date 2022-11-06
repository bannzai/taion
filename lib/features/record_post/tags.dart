import 'package:flutter/material.dart';
import 'package:taion/entity/record.codegen.dart';
import 'package:taion/features/record_post/util.dart';
import 'package:taion/style/color.dart';

class RecordPostTags extends StatelessWidget {
  final ValueNotifier<List<String>> tags;

  const RecordPostTags({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("体調詳細", style: secitonTitle),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: defaultTags.map((e) {
            isSelected() => tags.value.contains(e);
            return ChoiceChip(
              label: Text(e),
              labelStyle:
                  TextStyle(color: isSelected() ? Colors.white : Colors.grey),
              disabledColor: AppColor.secondaryBackground,
              selectedColor: AppColor.primary,
              selected: isSelected(),
              onSelected: (selected) {
                if (isSelected()) {
                  tags.value = tags.value..remove(e);
                } else {
                  tags.value = tags.value..add(e);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
