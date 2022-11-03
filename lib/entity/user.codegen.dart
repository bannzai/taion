import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taion/entity/firestore_converter.dart';

part 'user.codegen.freezed.dart';
part 'user.codegen.g.dart';

// Reference: https://developer.twitter.com/en/docs/twitter-api/v1/data-dictionary/object-model/user
@freezed
class User with _$User {
  @JsonSerializable(explicitToJson: true)
  factory User({
    required String? id,
    @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp,
    )
        required DateTime createdDateTime,
  }) = _User;
  User._();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
