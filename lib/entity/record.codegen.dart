
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taion/entity/firestore_converter.dart';

part 'record.codegen.freezed.dart';
part 'record.codegen.g.dart';

@freezed
class Record with _$Record {
  @JsonSerializable(explicitToJson: true)
  factory Record({
    required double temperature,
    required List<String> tags,
    required String memo,
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime takeTempertureDateTime,
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
  )
        required DateTime createdDateTime,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}
