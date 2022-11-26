import 'package:flutter/material.dart';
import 'package:taion/style/button.dart';
import 'package:taion/style/color.dart';
import 'package:taion/utility/analytics.dart';

const double keyboardToolbarHeight = 44;

class KeyboardToolbar extends StatelessWidget {
  const KeyboardToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: keyboardToolbarHeight,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: AppColor.secondaryBackground),
          child: Row(
            children: [
              const Spacer(),
              AppTextButton(
                text: const Text('完了',
                    style: TextStyle(
                        color: AppColor.primary, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  analytics.logEvent(name: "done_keyboard_toolbar");
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
      ],
    );
  }
}
