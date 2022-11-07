import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taion/features/record_post/util.dart';
import 'package:taion/style/color.dart';

class RecordPostTempertureDate extends StatelessWidget {
  final ValueNotifier<DateTime> tempertureDate;

  const RecordPostTempertureDate({super.key, required this.tempertureDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("測定日時", style: secitonTitle),
        const SizedBox(height: 8),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: tempertureDate.value,
                  firstDate: DateTime.parse("2020-01-01"),
                  lastDate: DateTime.now(),
                );
                if (date == null) {
                  return;
                }

                tempertureDate.value = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  tempertureDate.value.hour,
                  tempertureDate.value.minute,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(_date(),
                    style: const TextStyle(
                        color: AppColor.textMain, fontSize: 16)),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(tempertureDate.value),
                );
                if (timeOfDay == null) {
                  return;
                }

                tempertureDate.value = DateTime(
                  tempertureDate.value.year,
                  tempertureDate.value.month,
                  tempertureDate.value.day,
                  timeOfDay.hour,
                  timeOfDay.minute,
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(_time(),
                    style: const TextStyle(
                        color: AppColor.textMain, fontSize: 16)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _date() => DateFormat(DateFormat.YEAR_MONTH_DAY, "ja_JP")
      .format(tempertureDate.value);
  String _time() => DateFormat.Hms().format(tempertureDate.value);
}
