import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/style/color.dart';

class PrimaryButton extends HookWidget {
  final String text;
  final Future<void> Function()? onPressed;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isProcessing = useState(false);
    final isMounted = useIsMounted();

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        minimumSize: const Size.fromHeight(44),
      ),
      onPressed: onPressed == null
          ? null
          : () async {
              if (isProcessing.value) {
                return;
              }
              isProcessing.value = true;

              try {
                await onPressed?.call();
              } catch (error) {
                rethrow;
              } finally {
                if (isMounted()) {
                  isProcessing.value = false;
                }
              }
            },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44, minWidth: 220),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            if (isProcessing.value) _Loading(),
          ],
        ),
      ),
    );
  }
}

class GreyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const GreyButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        minimumSize: const Size.fromHeight(44),
      ),
      onPressed: onPressed,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44, minWidth: 180),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class DangerButton extends HookWidget {
  final String text;
  final Future<void> Function()? onPressed;

  const DangerButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isProcessing = useState(false);
    final isMounted = useIsMounted();
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: const Size.fromHeight(44),
        elevation: 0,
        side: const BorderSide(color: AppColor.danger),
      ),
      onPressed: onPressed == null
          ? null
          : () async {
              if (isProcessing.value) {
                return;
              }
              isProcessing.value = true;

              try {
                await onPressed?.call();
              } catch (error) {
                rethrow;
              } finally {
                if (isMounted()) {
                  isProcessing.value = false;
                }
              }
            },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 44, minWidth: 180),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: AppColor.danger,
              ),
            ),
            if (isProcessing.value) _Loading(),
          ],
        ),
      ),
    );
  }
}

class AppTextButton extends HookWidget {
  final Text text;
  final Future<void> Function()? onPressed;

  const AppTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isProcessing = useState(false);
    final isMounted = useIsMounted();

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      onPressed: isProcessing.value || onPressed == null
          ? null
          : () async {
              if (isProcessing.value) {
                return;
              }
              isProcessing.value = true;

              try {
                await onPressed?.call();
              } catch (error) {
                rethrow;
              } finally {
                if (isMounted()) {
                  isProcessing.value = false;
                }
              }
            },
      child: Stack(
        alignment: Alignment.center,
        children: [
          text,
          if (isProcessing.value) _Loading(),
        ],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 4,
        valueColor: AlwaysStoppedAnimation(Colors.orange),
      ),
    );
  }
}

class AlertButton extends HookWidget {
  final String text;
  final Future<void> Function()? onPressed;

  const AlertButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isProcessing = useState(false);
    final isMounted = useIsMounted();

    return TextButton(
      onPressed: onPressed == null
          ? null
          : () async {
              if (isProcessing.value) {
                return;
              }
              isProcessing.value = true;
              try {
                await onPressed?.call();
              } catch (error) {
                rethrow;
              } finally {
                if (isMounted()) isProcessing.value = false;
              }
            },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: (isProcessing.value || onPressed == null)
                    ? AppColor.textLightGray
                    : AppColor.primary),
          ),
          if (isProcessing.value) _Loading(),
        ],
      ),
    );
  }
}
