import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/entity/record.codegen.dart';
import 'package:taion/provider/record.dart';
import 'package:taion/provider/user.dart';
import 'package:taion/style/button.dart';
import 'package:taion/style/color.dart';
import 'package:taion/utility/const.dart';

const _secitonTitle = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 17,
  color: AppColor.textMain,
);

class RecordPostPage extends HookConsumerWidget {
  final DateTime dateTime;
  final Record? record;

  const RecordPostPage({required this.dateTime, required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userID = ref.watch(mustUserIDProvider);
    final setRecord = ref.watch(setRecordProvider);
    final tempureture = useState(record?.temperature);
    final tags = useState(record?.tags ?? []);
    final memo = useState(record?.memo ?? "");
    final takeTempertureDateTime = useState(record?.takeTempertureDateTime);
    final tempuretureValue = tempureture.value;
    final takeTempertureDateTimeValue = takeTempertureDateTime.value;

    final textEditingController = useTextEditingController(text: memo.value);
    final focusNode = useFocusNode();
    final scrollController = useScrollController();
    final offset =
        MediaQuery.of(context).viewInsets.bottom + keyboardToolbarHeight + 60;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          AppTextButton(
            text: const Text("保存", style: TextStyle(color: AppColor.primary)),
            onPressed: tempuretureValue == null ||
                    takeTempertureDateTimeValue == null
                ? null
                : () async {
                    final record = this.record;
                    if (record != null) {
                      await setRecord(
                        record.copyWith(
                          memo: memo.value,
                          tags: tags.value,
                          takeTempertureDateTime: takeTempertureDateTimeValue,
                          temperature: tempuretureValue,
                        ),
                        userID: userID,
                      );
                    } else {
                      await setRecord(
                        Record(
                          id: null,
                          temperature: tempuretureValue,
                          tags: tags.value,
                          memo: memo.value,
                          takeTempertureDateTime: takeTempertureDateTimeValue,
                          createdDateTime: DateTime.now(),
                        ),
                        userID: userID,
                      );
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, offset),
              child: ListView(
                controller: scrollController,
                children: [
                  Text(DateTimeFormatter.yearAndMonthAndDay(dateTime),
                      style: FontType.sBigTitle.merge(TextColorStyle.main)),
                  ...[
                    _physicalConditions(stateNotifier, state),
                    _physicalConditionDetails(context, stateNotifier, state),
                    _sex(stateNotifier, state),
                    _memo(context, textEditingController, focusNode,
                        stateNotifier, state),
                  ].map((e) => _withContentSpacer(e)),
                ],
              ),
            ),
            if (focusNode.hasFocus) _keyboardToolbar(context, focusNode),
          ],
        ),
      ),
    );
  }

  Widget _withContentSpacer(Widget content) {
    return Container(
      child: content,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
    );
  }

  Widget _physicalConditions(
      DiaryPostStateNotifier store, DiaryPostState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("体調", style: _secitonTitle),
        const Spacer(),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: PilllColors.divider,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                  color: state.diary.hasPhysicalConditionStatusFor(
                          PhysicalConditionStatus.bad)
                      ? PilllColors.thinSecondary
                      : Colors.transparent,
                ),
                child: IconButton(
                    icon: SvgPicture.asset("images/angry.svg",
                        color: state.diary.hasPhysicalConditionStatusFor(
                                PhysicalConditionStatus.bad)
                            ? PilllColors.secondary
                            : TextColor.darkGray),
                    onPressed: () {
                      store.switchingPhysicalCondition(
                          PhysicalConditionStatus.bad);
                    }),
              ),
              const SizedBox(
                  height: 48,
                  child: VerticalDivider(width: 1, color: PilllColors.divider)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: state.diary.hasPhysicalConditionStatusFor(
                          PhysicalConditionStatus.fine)
                      ? PilllColors.thinSecondary
                      : Colors.transparent,
                ),
                child: IconButton(
                    icon: SvgPicture.asset("images/laugh.svg",
                        color: state.diary.hasPhysicalConditionStatusFor(
                                PhysicalConditionStatus.fine)
                            ? PilllColors.secondary
                            : TextColor.darkGray),
                    onPressed: () {
                      store.switchingPhysicalCondition(
                          PhysicalConditionStatus.fine);
                    }),
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _physicalConditionDetails(BuildContext context,
      DiaryPostStateNotifier store, DiaryPostState state) {
    late List<String> physicalConditionDetails;
    if (state.premiumAndTrial.premiumOrTrial) {
      physicalConditionDetails =
          state.diarySetting?.physicalConditions ?? defaultPhysicalConditions;
    } else {
      physicalConditionDetails = defaultPhysicalConditions;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("体調詳細", style: _secitonTitle),
            const SizedBox(width: 12),
            IconButton(
              onPressed: () {
                analytics.logEvent(name: "edit_physical_condition_detail");
                if (state.premiumAndTrial.isPremium ||
                    state.premiumAndTrial.isTrial) {
                  showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child:
                              const DiarySettingPhysicalConditionDetailPage(),
                        );
                      });
                } else {
                  showPremiumIntroductionSheet(context);
                }
              },
              padding: const EdgeInsets.all(4),
              icon: const Icon(
                Icons.edit,
              ),
              iconSize: 20,
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          children: physicalConditionDetails
              .map((e) => ChoiceChip(
                    label: Text(e),
                    labelStyle: FontType.assisting.merge(
                        state.diary.physicalConditions.contains(e)
                            ? TextColorStyle.white
                            : TextColorStyle.darkGray),
                    disabledColor: PilllColors.disabledSheet,
                    selectedColor: PilllColors.secondary,
                    selected: state.diary.physicalConditions.contains(e),
                    onSelected: (selected) {
                      state.diary.physicalConditions.contains(e)
                          ? store.removePhysicalCondition(e)
                          : store.addPhysicalCondition(e);
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _sex(DiaryPostStateNotifier store, DiaryPostState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("sex", style: _secitonTitle),
        const SizedBox(width: 80),
        GestureDetector(
          onTap: () {
            store.toggleHasSex();
          },
          child: Container(
              padding: const EdgeInsets.all(4),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state.diary.hasSex
                      ? PilllColors.thinSecondary
                      : PilllColors.disabledSheet),
              child: SvgPicture.asset("images/heart.svg",
                  color: state.diary.hasSex
                      ? PilllColors.secondary
                      : TextColor.darkGray)),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _keyboardToolbar(BuildContext context, FocusNode focusNode) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      child: Container(
        height: keyboardToolbarHeight,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            const Spacer(),
            AlertButton(
              text: '完了',
              onPressed: () async {
                analytics.logEvent(name: "post_diary_done_button_pressed");
                focusNode.unfocus();
              },
            ),
          ],
        ),
        decoration: const BoxDecoration(color: PilllColors.white),
      ),
    );
  }

  Widget _memo(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    DiaryPostStateNotifier store,
    DiaryPostState state,
  ) {
    const textLength = 120;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        maxWidth: MediaQuery.of(context).size.width,
        minHeight: 40,
        maxHeight: 200,
      ),
      child: TextFormField(
        onChanged: (text) {
          store.editedMemo(text);
        },
        decoration: const InputDecoration(
          hintText: "メモ",
          border: OutlineInputBorder(),
        ),
        controller: textEditingController,
        maxLines: null,
        maxLength: textLength,
        keyboardType: TextInputType.multiline,
        focusNode: focusNode,
      ),
    );
  }
}

extension DiaryPostPageRoute on DiaryPostPage {
  static Route<dynamic> route(DateTime date, Diary? diary) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: "DiaryPostPage"),
      builder: (_) => DiaryPostPage(date, diary),
      fullscreenDialog: true,
    );
  }
}
