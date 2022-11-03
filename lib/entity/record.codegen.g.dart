// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      temperature: (json['temperature'] as num).toDouble(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      memo: json['memo'] as String,
      takeTempertureDateTime: NonNullTimestampConverter.timestampToDateTime(
          json['takeTempertureDateTime'] as Timestamp),
      createdDateTime: NonNullTimestampConverter.timestampToDateTime(
          json['createdDateTime'] as Timestamp),
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) => <String, dynamic>{
      'temperature': instance.temperature,
      'tags': instance.tags,
      'memo': instance.memo,
      'takeTempertureDateTime': NonNullTimestampConverter.dateTimeToTimestamp(
          instance.takeTempertureDateTime),
      'createdDateTime': NonNullTimestampConverter.dateTimeToTimestamp(
          instance.createdDateTime),
    };
