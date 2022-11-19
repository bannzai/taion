import 'package:flutter/material.dart';
import 'package:taion/style/button.dart';
import 'package:taion/style/color.dart';

class ErrorAlert extends StatelessWidget {
  final String? title;
  final String errorMessage;
  final String? faqLinkURL;

  const ErrorAlert(
      {Key? key, this.title, this.faqLinkURL, required this.errorMessage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final faq = faqLinkURL;
    return AlertDialog(
      title: Text(
        title ?? "エラーが発生しました",
        style: const TextStyle(
          color: AppColor.textMain,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Text(
        errorMessage,
        style: const TextStyle(
          color: AppColor.textMain,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
//        if (faq != null)
//          AlertButton(
//            text: "FAQを見る",
//            onPressed: () async {
//              launchUrl(Uri.parse(faq));
//            },
//          ),
        AlertButton(
          text: "閉じる",
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

void showErrorAlert(BuildContext context, Object error) {
  final String title;
  final String message;
  final String? faqLinkURL;
  if (error is FormatException) {
    title = "不明なエラーが発生しました";
    message = error.message;
    faqLinkURL = null;
  } else if (error is String) {
    title = "エラーが発生しました";
    message = error;
    faqLinkURL = null;
  } else {
    title = "予想外のエラーが発生しました";
    message = error.toString();
    faqLinkURL = null;
  }
  showDialog(
    context: context,
    builder: (_) {
      return ErrorAlert(
        title: title,
        errorMessage: message,
        faqLinkURL: faqLinkURL,
      );
    },
  );
}
