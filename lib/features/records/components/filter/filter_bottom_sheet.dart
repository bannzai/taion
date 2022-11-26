import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/features/records/components/filter/actor_select.dart';
import 'package:taion/features/record_post/record_tags.dart';
import 'package:taion/entity/actor.codegen.dart';
import 'package:taion/style/color.dart';

class RecordListFilterBottomSheet extends HookConsumerWidget {
  final ValueNotifier<Actor?> selectedActor;
  final ValueNotifier<List<String>> tags;
  const RecordListFilterBottomSheet(
      {super.key, required this.selectedActor, required this.tags});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = useState(DateTime.now());
    tags.addListener(() {
      _.value = DateTime.now();
    });
    selectedActor.addListener(() {
      _.value = DateTime.now();
    });
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
                  const SizedBox(height: 15),
                  RecordsFilterActorSelect(selectedActor: selectedActor),
                  const SizedBox(height: 15),
                  RecordPostRecordTags(selectedTags: tags),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
