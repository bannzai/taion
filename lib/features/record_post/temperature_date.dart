import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taion/style/color.dart';

class RecordPostTemperatureDate extends StatelessWidget {
  final ValueNotifier<DateTime> temperatureDate;

  const RecordPostTemperatureDate({super.key, required this.temperatureDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("測定日時",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 17,
              color: AppColor.textMain,
            )),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: temperatureDate.value,
                    firstDate: DateTime.parse("2020-01-01"),
                    lastDate: DateTime.now(),
                  );
                  if (date == null) {
                    return;
                  }

                  temperatureDate.value = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    temperatureDate.value.hour,
                    temperatureDate.value.minute,
                  );
                },
                child: Text(_date(), style: const TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () async {
                  final timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(temperatureDate.value),
                    initialEntryMode: TimePickerEntryMode.input,
                  );
                  if (timeOfDay == null) {
                    return;
                  }

                  temperatureDate.value = DateTime(
                    temperatureDate.value.year,
                    temperatureDate.value.month,
                    temperatureDate.value.day,
                    timeOfDay.hour,
                    timeOfDay.minute,
                  );
                },
                child: Text(_time(), style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _date() => DateFormat(DateFormat.YEAR_MONTH_DAY, "ja_JP")
      .format(temperatureDate.value);
  String _time() =>
      DateFormat(DateFormat.HOUR_MINUTE, "ja_JP").format(temperatureDate.value);
}
