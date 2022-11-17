import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taion/entity/record.codegen.dart';

import '../../style/color.dart';

class ListSectionHeader extends StatelessWidget {
  final Record firstRecordInMonth;
  const ListSectionHeader({super.key, required this.firstRecordInMonth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        _month(firstRecordInMonth.takeTempertureDateTime),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  String _month(DateTime tempertureDate) =>
      DateFormat(DateFormat.MONTH, "ja_JP").format(tempertureDate);
}

class ListItem extends StatelessWidget {
  final Record record;
  const ListItem({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _time(record.takeTempertureDateTime),
                style: const TextStyle(
                  color: AppColor.textMain,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "${record.temperature}",
            style: const TextStyle(
              color: AppColor.textMain,
              fontSize: 24,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  String _time(DateTime tempertureDate) =>
      DateFormat(DateFormat.HOUR_MINUTE, "ja_JP").format(tempertureDate);
}
