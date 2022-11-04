import 'package:flutter/material.dart';
import 'package:taion/style/color.dart';

class RecordListEmpty extends StatelessWidget {
  const RecordListEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("初めての記録をしましょう",
              style: TextStyle(fontSize: 20, color: AppColor.textMain)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColor.primary,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "images/body-temperture.svg",
                height: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
