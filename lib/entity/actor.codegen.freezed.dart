// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'actor.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Actor _$ActorFromJson(Map<String, dynamic> json) {
  return _Actor.fromJson(json);
}

/// @nodoc
class _$ActorTearOff {
  const _$ActorTearOff();

  _Actor call(
      {required String? id,
      required String name,
      required String iconEmoji,
      required int iconColorHexCode,
      required int index,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime createdDateTime}) {
    return _Actor(
      id: id,
      name: name,
      iconEmoji: iconEmoji,
      iconColorHexCode: iconColorHexCode,
      index: index,
      createdDateTime: createdDateTime,
    );
  }

  Actor fromJson(Map<String, Object?> json) {
    return Actor.fromJson(json);
  }
}

/// @nodoc
const $Actor = _$ActorTearOff();

/// @nodoc
mixin _$Actor {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get iconEmoji => throw _privateConstructorUsedError;
  int get iconColorHexCode => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get createdDateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActorCopyWith<Actor> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActorCopyWith<$Res> {
  factory $ActorCopyWith(Actor value, $Res Function(Actor) then) =
      _$ActorCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String name,
      String iconEmoji,
      int iconColorHexCode,
      int index,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime createdDateTime});
}

/// @nodoc
class _$ActorCopyWithImpl<$Res> implements $ActorCopyWith<$Res> {
  _$ActorCopyWithImpl(this._value, this._then);

  final Actor _value;
  // ignore: unused_field
  final $Res Function(Actor) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? iconEmoji = freezed,
    Object? iconColorHexCode = freezed,
    Object? index = freezed,
    Object? createdDateTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconEmoji: iconEmoji == freezed
          ? _value.iconEmoji
          : iconEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      iconColorHexCode: iconColorHexCode == freezed
          ? _value.iconColorHexCode
          : iconColorHexCode // ignore: cast_nullable_to_non_nullable
              as int,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      createdDateTime: createdDateTime == freezed
          ? _value.createdDateTime
          : createdDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$ActorCopyWith<$Res> implements $ActorCopyWith<$Res> {
  factory _$ActorCopyWith(_Actor value, $Res Function(_Actor) then) =
      __$ActorCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String name,
      String iconEmoji,
      int iconColorHexCode,
      int index,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime createdDateTime});
}

/// @nodoc
class __$ActorCopyWithImpl<$Res> extends _$ActorCopyWithImpl<$Res>
    implements _$ActorCopyWith<$Res> {
  __$ActorCopyWithImpl(_Actor _value, $Res Function(_Actor) _then)
      : super(_value, (v) => _then(v as _Actor));

  @override
  _Actor get _value => super._value as _Actor;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? iconEmoji = freezed,
    Object? iconColorHexCode = freezed,
    Object? index = freezed,
    Object? createdDateTime = freezed,
  }) {
    return _then(_Actor(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconEmoji: iconEmoji == freezed
          ? _value.iconEmoji
          : iconEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      iconColorHexCode: iconColorHexCode == freezed
          ? _value.iconColorHexCode
          : iconColorHexCode // ignore: cast_nullable_to_non_nullable
              as int,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      createdDateTime: createdDateTime == freezed
          ? _value.createdDateTime
          : createdDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Actor extends _Actor {
  _$_Actor(
      {required this.id,
      required this.name,
      required this.iconEmoji,
      required this.iconColorHexCode,
      required this.index,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required this.createdDateTime})
      : super._();

  factory _$_Actor.fromJson(Map<String, dynamic> json) =>
      _$$_ActorFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String iconEmoji;
  @override
  final int iconColorHexCode;
  @override
  final int index;
  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  final DateTime createdDateTime;

  @override
  String toString() {
    return 'Actor(id: $id, name: $name, iconEmoji: $iconEmoji, iconColorHexCode: $iconColorHexCode, index: $index, createdDateTime: $createdDateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Actor &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.iconEmoji, iconEmoji) &&
            const DeepCollectionEquality()
                .equals(other.iconColorHexCode, iconColorHexCode) &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality()
                .equals(other.createdDateTime, createdDateTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(iconEmoji),
      const DeepCollectionEquality().hash(iconColorHexCode),
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(createdDateTime));

  @JsonKey(ignore: true)
  @override
  _$ActorCopyWith<_Actor> get copyWith =>
      __$ActorCopyWithImpl<_Actor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ActorToJson(this);
  }
}

abstract class _Actor extends Actor {
  factory _Actor(
      {required String? id,
      required String name,
      required String iconEmoji,
      required int iconColorHexCode,
      required int index,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime createdDateTime}) = _$_Actor;
  _Actor._() : super._();

  factory _Actor.fromJson(Map<String, dynamic> json) = _$_Actor.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get iconEmoji;
  @override
  int get iconColorHexCode;
  @override
  int get index;
  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get createdDateTime;
  @override
  @JsonKey(ignore: true)
  _$ActorCopyWith<_Actor> get copyWith => throw _privateConstructorUsedError;
}
