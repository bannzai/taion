import 'package:flutter/material.dart';
import 'package:taion/style/button.dart';
import 'package:taion/style/color.dart';

class DangerDialog extends StatelessWidget {
  final String title;
  final String message;
  final AlertButton confirmationButton;

  const DangerDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmationButton,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Icon(Icons.warning),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: AppColor.textMain,
                fontSize: 17,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(message,
              style: const TextStyle(
                  color: AppColor.textMain,
                  fontSize: 14,
                  fontWeight: FontWeight.w300)),
        ],
      ),
      actions: [
        confirmationButton,
        AlertButton(
          onPressed: () async => Navigator.of(context).pop(),
          text: "キャンセル",
        ),
      ],
    );
  }
}
