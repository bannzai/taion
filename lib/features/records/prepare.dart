import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/entity/actor.codegen.dart';
import 'package:taion/provider/actor.dart';
import 'package:taion/provider/user.dart';

class RecordListPrepare extends HookConsumerWidget {
  final List<Actor> actors;
  const RecordListPrepare({
    super.key,
    required this.actors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userID = ref.watch(mustUserIDProvider);
    useEffect(() {
      if (actors.isEmpty) {
        final actor = Actor.create(index: 0, name: "自分");
        unawaited(ref.read(setActorProvider).call(actor, userID: userID));
      }
      return null;
    }, [true]);

    return const Center(child: CircularProgressIndicator());
  }
}
