import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/entity/actor.codegen.dart';

class ActorPostPage extends HookConsumerWidget {
  const ActorPostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  const SizedBox(height: 20),
                  RecordPostTempurature(
                    temperature: temperature,
                    textEditingController: temperatureTextEditingController,
                    focusNode: temperatureFocusNode,
                  ),
                  const SizedBox(height: 20),
                  RecordPostTemperatureDate(
                      temperatureDate: takeTemperatureDateTime),
                  const SizedBox(height: 20),
                  RecordTags(selectedTags: tags),
                  const SizedBox(height: 20),
                  RecordPostMemo(
                    memo: memo,
                    textEditingController: memoTextEditingController,
                    focusNode: memoFocusNode,
                  ),
                  if (record != null) ...[
                    RecordPostDeleteButton(record: record)
                  ],
                  const SizedBox(height: 20),
                ],
              ),
            ),
            if (memoFocusNode.hasFocus) ...[
              _keyboardToolbar(context, memoFocusNode),
              SizedBox(height: offset),
            ],
            if (temperatureFocusNode.hasFocus) ...[
              _keyboardToolbar(context, temperatureFocusNode),
              SizedBox(height: offset),
            ],
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
        CircleAvatar(
          child: Text(actor.iconEmoji),
        )
      ],
    );
  }
}
