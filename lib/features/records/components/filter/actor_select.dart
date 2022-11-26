import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/entity/actor.codegen.dart';
import 'package:taion/features/actors/page.dart';
import 'package:taion/provider/actor.dart';
import 'package:taion/style/color.dart';

class RecordsFilterActorSelect extends HookConsumerWidget {
  final ValueNotifier<Actor?> selectedActor;

  const RecordsFilterActorSelect({super.key, required this.selectedActor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(actorsProvider).when(
        data: (actors) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text(
                    "記録される人",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                      color: AppColor.textMain,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(ActorsPageRoute.route());
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final actor in actors)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(actor.name),
                          labelPadding: const EdgeInsets.all(4),
                          avatar: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.8),
                            foregroundColor: Color(actor.colorHexCode),
                            child: Text(actor.iconChar,
                                style: TextStyle(
                                    color: Color(actor.colorHexCode),
                                    fontWeight: FontWeight.w600)),
                          ),
                          selectedColor: Color(actor.colorHexCode),
                          selected: selectedActor.value?.id == actor.id,
                          onSelected: (selected) {
                            if (selected) {
                              selectedActor.value = actor;
                            } else {
                              selectedActor.value = null;
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (e, st) => Text(e.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
