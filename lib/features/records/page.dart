import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taion/entity/record.codegen.dart';
import 'package:taion/entity/user.codegen.dart';
import 'package:taion/features/error/page.dart';
import 'package:taion/features/records/empty.dart';
import 'package:taion/provider/record.dart';
import 'package:taion/provider/user.dart';
import 'package:taion/style/color.dart';
import 'package:taion/utility/async_value_group.dart';

class RecordListPage extends HookConsumerWidget {
  const RecordListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueGroup.group2(
      ref.watch(recordsProvider),
      ref.watch(userProvider),
    ).when(
      data: (t) => t.a1.isEmpty
          ? const RecordListEmpty()
          : RecordListBody(records: t.a1, user: t.a2),
      error: (error, st) =>
          ErrorPage(error: error, reload: () => ref.refresh(recordsProvider)),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class RecordListBody extends StatelessWidget {
  final List<Record> records;
  final User? user;

  const RecordListBody({super.key, required this.records, required this.user});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              for (final record in records)
                Row(
                  children: [
                    Text(_dateTime(record.takeTempertureDateTime),
                        style:
                            const TextStyle(color: AppColor.textMain, fontSize: 14)),
                    Text("${record.temperature}",
                        style:
                            const TextStyle(color: AppColor.textMain, fontSize: 14)),
                  ],
                ),
              Positioned(
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Navigator.of(context).push(UserPageRoute.route());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static String _dateTime(DateTime dateTime) {
    return DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY, "ja_JP")
            .format(dateTime) +
        DateFormat.jms().format(dateTime);
  }
}
