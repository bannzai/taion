import 'package:flutter/material.dart';
import 'package:taion/style/color.dart';

const double keyboardToolbarHeight = 44;

class KeyboardToolbar extends StatelessWidget {
  final Widget doneButton;
  const KeyboardToolbar({super.key, required this.doneButton});

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
              doneButton,
              const SizedBox(width: 20),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
      ],
    );
  }
}
