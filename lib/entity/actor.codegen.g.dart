// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actor.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Actor _$$_ActorFromJson(Map<String, dynamic> json) => _$_Actor(
      id: json['id'] as String?,
      name: json['name'] as String,
      hexColorCode: json['hexColorCode'] as int,
      index: json['index'] as int,
      createdDateTime: NonNullTimestampConverter.timestampToDateTime(
          json['createdDateTime'] as Timestamp),
    );

Map<String, dynamic> _$$_ActorToJson(_$_Actor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hexColorCode': instance.hexColorCode,
      'index': instance.index,
      'createdDateTime': NonNullTimestampConverter.dateTimeToTimestamp(
          instance.createdDateTime),
    };
