import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/entity/actor.codegen.dart';
import 'package:taion/features/record_post/page.dart';
import 'package:taion/provider/actor.dart';
import 'package:taion/provider/user.dart';
import 'package:taion/style/color.dart';

class RecordListEmpty extends HookConsumerWidget {
  final List<Actor> actors;
  const RecordListEmpty({
    Key? key,
    required this.actors,
  }) : super(key: key);

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

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("初めての記録をしましょう",
                style: TextStyle(fontSize: 20, color: AppColor.textMain)),
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(RecordPostPageRoute.route(record: null));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  shape: const CircleBorder(),
                ),
                child: SvgPicture.asset(
                  "images/body-temperture.svg",
                  color: Colors.white,
                  height: 48,
                  width: 48,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
