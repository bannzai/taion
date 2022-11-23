import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taion/entity/firestore_converter.dart';

part 'actor.codegen.freezed.dart';
part 'actor.codegen.g.dart';

@freezed
class Actor with _$Actor {
  @JsonSerializable(explicitToJson: true)
  factory Actor({
    required String? id,
    required String name,
    required String iconEmoji,
    required String iconColorHexCode,
    required int index,
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime createdDateTime,
  }) = _Actor;
  Actor._();

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
}
