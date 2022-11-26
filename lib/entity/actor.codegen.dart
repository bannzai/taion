import 'dart:math';

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
    required int colorHexCode,
    required int index,
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime createdDateTime,
  }) = _Actor;
  Actor._();

  String get iconChar => name.substring(0, 1);

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
  factory Actor.create({required int index, required String name}) => Actor(
      id: null,
      name: name,
      colorHexCode: _randomColorHexCode(),
      index: index,
      createdDateTime: DateTime.now());
}

int _randomColorHexCode() {
  return (Random().nextDouble() * 0xFFFFFFFF).toInt();
}

// String _randomEmoji() {
//   final emojis = _emojis();
//   return emojis[Random().nextInt(emojis.length - 1)];
// }
// 
// List<String> _emojis() {
//   return _range().map((e) => String.fromCharCode(e)).toList();
// }
// 
// Iterable<int> _range() sync* {
//   const start = 0x1F601;
//   const stop = 0x1F64F;
// 
//   for (int value = start; value < stop; value += 1) {
//     yield value;
//   }
// }
// 