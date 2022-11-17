import 'package:async_value_group/async_value_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taion/entity/record.codegen.dart';
import 'package:taion/entity/user.codegen.dart';
import 'package:taion/features/error/page.dart';
import 'package:taion/features/records/component.dart';
import 'package:taion/features/records/empty.dart';
import 'package:taion/provider/record.dart';
import 'package:taion/provider/user.dart';
import 'package:taion/style/color.dart';
import 'package:taion/utility/date.dart';

class RecordListPage extends HookConsumerWidget {
  const RecordListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueGroup.group2(
      ref.watch(recordsProvider),
      ref.watch(userProvider),
    ).when(
      data: (t) => t.t1.isEmpty
          ? const RecordListEmpty()
          : RecordListBody(records: t.t1, user: t.t2),
      error: (error, st) =>
          ErrorPage(error: error, reload: () => ref.refresh(recordsProvider)),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class RecordListBody extends HookConsumerWidget {
  final List<Record> records;
  final User? user;

  const RecordListBody({super.key, required this.records, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateForMonth = useState(DateTime.now());
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Navigator.of(context).push(UserPageRoute.route());
          },
        ),
      ]),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              _month(dateForMonth.value),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                shrinkWrap: true,
                children: [
                  for (final day in _days(dateForMonth.value)) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 30,
                          child: Text(
                            "$day",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              for (final record in _filterRecords(
                                  dateForMonth: dateForMonth.value,
                                  day: day)) ...[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      _time(record.takeTempertureDateTime),
                                      style: const TextStyle(
                                        color: AppColor.textMain,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${record.temperature}",
                                      style: const TextStyle(
                                        color: AppColor.textMain,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.red,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Record> _filterRecords({
    required DateTime dateForMonth,
    required int day,
  }) =>
      records
          .where((element) => isSameDay(
                element.takeTempertureDateTime,
                DateTime(dateForMonth.year, dateForMonth.month, day),
              ))
          .toList();

  List<int> _days(DateTime dateForMonth) {
    final lastDay = DateTime(dateForMonth.year, dateForMonth.month + 1, 0).day;
    return List.generate(lastDay, (index) => index + 1);
  }

  String _month(DateTime tempertureDate) =>
      DateFormat(DateFormat.MONTH, "ja_JP").format(tempertureDate);
  String _day(DateTime tempertureDate) =>
      DateFormat(DateFormat.DAY, "ja_JP").format(tempertureDate);
  String _time(DateTime tempertureDate) =>
      DateFormat(DateFormat.HOUR_MINUTE, "ja_JP").format(tempertureDate);
}
