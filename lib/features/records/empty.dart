import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taion/entity/actor.codegen.dart';
import 'package:taion/features/record_post/page.dart';
import 'package:taion/style/color.dart';

class RecordListEmpty extends StatelessWidget {
  final Actor currentActor;
  const RecordListEmpty({
    Key? key,
    required this.currentActor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
