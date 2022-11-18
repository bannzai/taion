// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      id: json['id'] as String?,
      temperature: (json['temperature'] as num).toDouble(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      memo: json['memo'] as String,
      takeTemperatureDateTime: NonNullTimestampConverter.timestampToDateTime(
          json['takeTemperatureDateTime'] as Timestamp),
      createdDateTime: NonNullTimestampConverter.timestampToDateTime(
          json['createdDateTime'] as Timestamp),
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) => <String, dynamic>{
      'id': instance.id,
      'temperature': instance.temperature,
      'tags': instance.tags,
      'memo': instance.memo,
      'takeTemperatureDateTime': NonNullTimestampConverter.dateTimeToTimestamp(
          instance.takeTemperatureDateTime),
      'createdDateTime': NonNullTimestampConverter.dateTimeToTimestamp(
          instance.createdDateTime),
    };
