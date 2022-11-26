import 'dart:async';

import 'package:async_value_group/async_value_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:taion/components/record_tags/record_tags.dart';
import 'package:taion/entity/actor.codegen.dart';
import 'package:taion/entity/record.codegen.dart';
import 'package:taion/entity/user.codegen.dart';
import 'package:taion/features/error/page.dart';
import 'package:taion/features/record_post/page.dart';
import 'package:taion/features/records/components/filter/filter_bottom_sheet.dart';
import 'package:taion/features/records/empty.dart';
import 'package:taion/provider/actor.dart';
import 'package:taion/provider/record.dart';
import 'package:taion/provider/user.dart';
import 'package:taion/style/color.dart';
import 'package:taion/utility/date.dart';

class RecordListPage extends HookConsumerWidget {
  const RecordListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueGroup.group3(
      ref.watch(recordsProvider),
      ref.watch(actorsProvider),
      ref.watch(currentActorProvider),
    ).when(
      data: (t) {
        final records = t.t1;
        final actors = t.t2;
        final currentActor = t.t3;
        return records.isEmpty || currentActor == null
            ? RecordListEmpty(actors: actors)
            : RecordListBody(records: records, actors: actors);
      },
      error: (error, st) =>
          ErrorPage(error: error, reload: () => ref.refresh(recordsProvider)),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class RecordListBody extends HookConsumerWidget {
  final List<Record> records;
  final List<Actor> actors;

  const RecordListBody({
    super.key,
    required this.records,
    required this.actors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateForMonth = useState(DateTime.now());
    final daysOfMonth = _days(dateForMonth.value);
    final tags = useState<List<String>>([]);

    return Scaffold(
      appBar: AppBar(
        title: MonthHeader(dateForMonth: dateForMonth),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => RecordListFilterBottomSheet(tags: tags),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(RecordPostPageRoute.route(record: null));
        },
      ),
      body: SafeArea(
        child: _recordIsExistInMonth(dateForMonth: dateForMonth.value)
            ? ListView.builder(
                itemCount: daysOfMonth.length,
                itemBuilder: (context, index) {
                  final day = daysOfMonth[index];
                  final List<Record> records = () {
                    final recordsInDay = _recordsInDay(
                      dateForMonth: dateForMonth.value,
                      day: day,
                    );
                    final List<Record> records;
                    if (tags.value.isEmpty) {
                      records = recordsInDay;
                    } else {
                      records = recordsInDay.where((record) {
                        return tags.value.where((tag) {
                          return record.tags.contains(tag);
                        }).isNotEmpty;
                      }).toList();
                    }
                    return records;
                  }();

                  if (records.isEmpty) {
                    return Container();
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: StickyHeader(
                          header: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 2),
                                color: AppColor.lightGray,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "$day日(${_weekday(DateTime(dateForMonth.value.year, dateForMonth.value.month, day))})",
                                  style: const TextStyle(
                                      fontSize: 13, color: AppColor.textGray),
                                ),
                              ),
                              Divider(
                                  height: 1,
                                  color: Colors.black.withAlpha(200)),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (final record in records) ...[
                                RecordListItem(record: record),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: record.id == records.last.id ? 0 : 12,
                                  ),
                                  child: const Divider(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            : const RecordListEmpty(),
      ),
    );
  }

  bool _recordIsExistInMonth({required DateTime dateForMonth}) => records
      .where((element) =>
          isSameMonth(element.takeTemperatureDateTime, dateForMonth))
      .isNotEmpty;

  List<Record> _recordsInDay({
    required DateTime dateForMonth,
    required int day,
  }) =>
      records
          .where((element) => isSameDay(
                element.takeTemperatureDateTime,
                DateTime(dateForMonth.year, dateForMonth.month, day),
              ))
          .toList();

  List<int> _days(DateTime dateForMonth) {
    final lastDay = DateTime(dateForMonth.year, dateForMonth.month + 1, 0).day;
    return List.generate(lastDay, (index) => index + 1);
  }
}

class RecordListItem extends StatelessWidget {
  const RecordListItem({
    Key? key,
    required this.record,
  }) : super(key: key);

  final Record record;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(RecordPostPageRoute.route(record: record));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              _time(record.takeTemperatureDateTime),
              style: const TextStyle(
                color: AppColor.textMain,
                fontSize: 15,
              ),
            ),
            const Spacer(),
            Text(
              "${record.temperature}℃",
              style: const TextStyle(
                color: AppColor.textMain,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthHeader extends StatelessWidget {
  final ValueNotifier<DateTime> dateForMonth;
  const MonthHeader({super.key, required this.dateForMonth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          IconButton(
              onPressed: () {
                dateForMonth.value = DateTime(dateForMonth.value.year,
                    dateForMonth.value.month - 1, dateForMonth.value.day);
              },
              icon: const Icon(Icons.arrow_left)),
          const Spacer(flex: 2),
          Text(
            _yearMonth(dateForMonth.value),
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(flex: 2),
          IconButton(
              onPressed: () {
                dateForMonth.value = DateTime(dateForMonth.value.year,
                    dateForMonth.value.month + 1, dateForMonth.value.day);
              },
              icon: const Icon(Icons.arrow_right_outlined)),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

String _yearMonth(DateTime tempertureDate) =>
    DateFormat(DateFormat.YEAR_MONTH, "ja_JP").format(tempertureDate);
String _weekday(DateTime date) =>
    DateFormat(DateFormat.ABBR_WEEKDAY, "ja_JP").format(date);
String _time(DateTime tempertureDate) =>
    DateFormat(DateFormat.HOUR_MINUTE, "ja_JP").format(tempertureDate);
