import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/components/keyboard/keyboard_toolbar.dart';
import 'package:taion/entity/actor.codegen.dart';
import 'package:taion/provider/actor.dart';

class ActorsPage extends HookConsumerWidget {
  const ActorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actors = ref.watch(actorsProvider).valueOrNull;
    final scrollController = useScrollController();
    final nameFocusNode = useFocusNode();

    if (actors == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                controller: scrollController,
                children: [
                  for (final actor in actors)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ActorListItem(actor: actor),
                    ),
                ],
              ),
            ),
            KeyboardToolbar(focusNode: nameFocusNode),
          ],
        ),
      ),
    );
  }
}

class ActorListItem extends StatelessWidget {
  final Actor actor;
  const ActorListItem({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Color(actor.colorHexCode),
            child: Text(actor.iconChar),
          ),
        ),
        const SizedBox(width: 16),
        Text(actor.name),
      ],
    );
  }
}
