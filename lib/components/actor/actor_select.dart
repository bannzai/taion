import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/entity/actor.codegen.dart';
import 'package:taion/features/actors/page.dart';
import 'package:taion/provider/actor.dart';
import 'package:taion/style/color.dart';

class ActorSelect extends HookConsumerWidget {
  final ValueNotifier<Actor> selectedActor;

  const ActorSelect({super.key, required this.selectedActor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actors = ref.watch(actorsProvider).valueOrNull;
    if (actors == null) {
      return const CircularProgressIndicator();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Text(
              "対象の人",
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
              icon: const Icon(Icons.add),
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
                      child: Text(actor.iconChar),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    selected: selectedActor.value.id == actor.id,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
