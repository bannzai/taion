import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/components/keyboard/keyboard_toolbar.dart';
import 'package:taion/entity/actor.codegen.dart';
import 'package:taion/features/error/page.dart';
import 'package:taion/provider/actor.dart';
import 'package:taion/provider/shared_preferences.dart';
import 'package:taion/provider/user.dart';
import 'package:taion/style/color.dart';

class ActorsPage extends HookConsumerWidget {
  const ActorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(actorsProvider).when(
        data: (actors) => ActorsPageBody(actors: actors),
        error: (e, st) =>
            ErrorPage(error: e, reload: () => ref.refresh(actorsProvider)),
        loading: () => const CircularProgressIndicator());
  }
}

class ActorsPageBody extends HookConsumerWidget {
  final List<Actor> actors;
  const ActorsPageBody({super.key, required this.actors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setActor = ref.watch(setActorProvider);
    final userID = ref.watch(mustUserIDProvider);
    final scrollController = useScrollController();

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
        actions: [
          IconButton(
            onPressed: () {
              final index = actors.length;
              setActor(
                Actor.create(index: index, name: "グループ $index"),
                userID: userID,
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [
                  const Divider(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  for (final actor in actors)
                    Column(children: [
                      ActorListItem(actor: actor),
                      const Divider(
                        height: 0.5,
                        color: Colors.grey,
                      ),
                    ]),
                ],
              ),
            ),
            const KeyboardToolbar(),
          ],
        ),
      ),
    );
  }
}

abstract class ActorsPageRoute {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: "ActorsPage"),
      builder: (_) => const ActorsPage(),
      fullscreenDialog: true,
    );
  }
}

class ActorListItem extends HookConsumerWidget {
  final Actor actor;
  const ActorListItem({super.key, required this.actor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userID = ref.watch(mustUserIDProvider);
    final setActor = ref.watch(setActorProvider);
    final currentActor = ref.watch(mustCurrentActorProvider);
    final color = useState(Color(actor.colorHexCode));
    final latestUsedActorIDNotifier = ref.watch(
        stringSharedPreferencesProvider(StringKey.latestUsedActorID).notifier);
    final textEditingController = useTextEditingController(text: actor.name);
    final nameFocusNode = useFocusNode();

    return GestureDetector(
      onTap: () {
        latestUsedActorIDNotifier.set(actor.id!);
      },
      child: Dismissible(
        key: Key(actor.id!),
        onDismissed: (_) {
          ref.read(deleteActorProvider).call(actor, userID: userID);
        },
        background: Container(
          color: Colors.red,
          child: const SizedBox(
            width: 40,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "削除",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: color.value,
                            onColorChanged: (value) => color.value = value,
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('閉じる'),
                            onPressed: () async {
                              setActor(
                                actor.copyWith(colorHexCode: color.value.value),
                                userID: userID,
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(actor.colorHexCode),
                    child: Text(
                      actor.iconChar,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  autofocus: false,
                  focusNode: nameFocusNode,
                  controller: textEditingController,
                  maxLines: 1,
                  maxLength: 8,
                  style: const TextStyle(
                    color: AppColor.textMain,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: null,
                ),
              ),
//              Text(actor.name,
//                  style: const TextStyle(
//                      fontSize: 15, fontWeight: FontWeight.w500)),
              SizedBox(
                  width: 30,
                  height: 30,
                  child: actor.id == currentActor.id
                      ? const Icon(Icons.check, color: Colors.black)
                      : Container()),
            ],
          ),
        ),
      ),
    );
  }
}
