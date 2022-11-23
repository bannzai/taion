import 'package:flutter/material.dart';
import 'package:taion/components/record_tags/record_tags.dart';
import 'package:taion/style/color.dart';

class RecordListFilterBottomSheet extends StatelessWidget {
  final ValueNotifier<List<String>> tags;
  const RecordListFilterBottomSheet({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.7,
      builder: (context, _) {
        return SizedBox.expand(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 21.0, left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "絞り込み",
                    style: TextStyle(
                        color: AppColor.textMain,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  RecordTags(tags: tags)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
