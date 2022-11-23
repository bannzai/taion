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
    required String iconEmoji,
    required int iconColorHexCode,
    required int index,
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime createdDateTime,
  }) = _Actor;
  Actor._();

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
//  factory Actor.create({required int index}) => Actor(
//      id: null,
//      name: "グループ $index",
//      iconEmoji: _randomEmoji(),
//      iconColorHexCode: _randomColorHexCode(),
//      index: index,
//      createdDateTime: DateTime.now());
}

//int _randomColorHexCode() {
//  return (Random().nextDouble() * 0xFFFFFF).toInt();
//// emojis()
//}
//
//String _randomEmoji() {
//  final emojis = _emojis();
//  return emojis[Random().nextInt(emojis.length - 1)];
//}
//
//List<String> _emojis() {
//  return _range().map((e) => String.fromCharCode(e)).toList();
//}
//
//Iterable<int> _range() sync* {
//  final start = 0x1F601;
//  final stop = 0x1F64F;
//
//  for (int value = start; value < stop; value += 1) {
//    yield value;
//  }
//}
//