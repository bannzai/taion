// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'record.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Record _$RecordFromJson(Map<String, dynamic> json) {
  return _Record.fromJson(json);
}

/// @nodoc
class _$RecordTearOff {
  const _$RecordTearOff();

  _Record call(
      {required double temperature,
      required List<String> tags,
      required String memo,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime takeTempertureDateTime,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime createdDateTime}) {
    return _Record(
      temperature: temperature,
      tags: tags,
      memo: memo,
      takeTempertureDateTime: takeTempertureDateTime,
      createdDateTime: createdDateTime,
    );
  }

  Record fromJson(Map<String, Object?> json) {
    return Record.fromJson(json);
  }
}

/// @nodoc
const $Record = _$RecordTearOff();

/// @nodoc
mixin _$Record {
  double get temperature => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get takeTempertureDateTime => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get createdDateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordCopyWith<Record> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordCopyWith<$Res> {
  factory $RecordCopyWith(Record value, $Res Function(Record) then) =
      _$RecordCopyWithImpl<$Res>;
  $Res call(
      {double temperature,
      List<String> tags,
      String memo,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime takeTempertureDateTime,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime createdDateTime});
}

/// @nodoc
class _$RecordCopyWithImpl<$Res> implements $RecordCopyWith<$Res> {
  _$RecordCopyWithImpl(this._value, this._then);

  final Record _value;
  // ignore: unused_field
  final $Res Function(Record) _then;

  @override
  $Res call({
    Object? temperature = freezed,
    Object? tags = freezed,
    Object? memo = freezed,
    Object? takeTempertureDateTime = freezed,
    Object? createdDateTime = freezed,
  }) {
    return _then(_value.copyWith(
      temperature: temperature == freezed
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      takeTempertureDateTime: takeTempertureDateTime == freezed
          ? _value.takeTempertureDateTime
          : takeTempertureDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdDateTime: createdDateTime == freezed
          ? _value.createdDateTime
          : createdDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$RecordCopyWith<$Res> implements $RecordCopyWith<$Res> {
  factory _$RecordCopyWith(_Record value, $Res Function(_Record) then) =
      __$RecordCopyWithImpl<$Res>;
  @override
  $Res call(
      {double temperature,
      List<String> tags,
      String memo,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime takeTempertureDateTime,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          DateTime createdDateTime});
}

/// @nodoc
class __$RecordCopyWithImpl<$Res> extends _$RecordCopyWithImpl<$Res>
    implements _$RecordCopyWith<$Res> {
  __$RecordCopyWithImpl(_Record _value, $Res Function(_Record) _then)
      : super(_value, (v) => _then(v as _Record));

  @override
  _Record get _value => super._value as _Record;

  @override
  $Res call({
    Object? temperature = freezed,
    Object? tags = freezed,
    Object? memo = freezed,
    Object? takeTempertureDateTime = freezed,
    Object? createdDateTime = freezed,
  }) {
    return _then(_Record(
      temperature: temperature == freezed
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      takeTempertureDateTime: takeTempertureDateTime == freezed
          ? _value.takeTempertureDateTime
          : takeTempertureDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdDateTime: createdDateTime == freezed
          ? _value.createdDateTime
          : createdDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Record implements _Record {
  _$_Record(
      {required this.temperature,
      required this.tags,
      required this.memo,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required this.takeTempertureDateTime,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required this.createdDateTime});

  factory _$_Record.fromJson(Map<String, dynamic> json) =>
      _$$_RecordFromJson(json);

  @override
  final double temperature;
  @override
  final List<String> tags;
  @override
  final String memo;
  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  final DateTime takeTempertureDateTime;
  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  final DateTime createdDateTime;

  @override
  String toString() {
    return 'Record(temperature: $temperature, tags: $tags, memo: $memo, takeTempertureDateTime: $takeTempertureDateTime, createdDateTime: $createdDateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Record &&
            const DeepCollectionEquality()
                .equals(other.temperature, temperature) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            const DeepCollectionEquality().equals(other.memo, memo) &&
            const DeepCollectionEquality()
                .equals(other.takeTempertureDateTime, takeTempertureDateTime) &&
            const DeepCollectionEquality()
                .equals(other.createdDateTime, createdDateTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(temperature),
      const DeepCollectionEquality().hash(tags),
      const DeepCollectionEquality().hash(memo),
      const DeepCollectionEquality().hash(takeTempertureDateTime),
      const DeepCollectionEquality().hash(createdDateTime));

  @JsonKey(ignore: true)
  @override
  _$RecordCopyWith<_Record> get copyWith =>
      __$RecordCopyWithImpl<_Record>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordToJson(this);
  }
}

abstract class _Record implements Record {
  factory _Record(
      {required double temperature,
      required List<String> tags,
      required String memo,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime takeTempertureDateTime,
      @JsonKey(fromJson: NonNullTimestampConverter.timestampToDateTime, toJson: NonNullTimestampConverter.dateTimeToTimestamp)
          required DateTime createdDateTime}) = _$_Record;

  factory _Record.fromJson(Map<String, dynamic> json) = _$_Record.fromJson;

  @override
  double get temperature;
  @override
  List<String> get tags;
  @override
  String get memo;
  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get takeTempertureDateTime;
  @override
  @JsonKey(
      fromJson: NonNullTimestampConverter.timestampToDateTime,
      toJson: NonNullTimestampConverter.dateTimeToTimestamp)
  DateTime get createdDateTime;
  @override
  @JsonKey(ignore: true)
  _$RecordCopyWith<_Record> get copyWith => throw _privateConstructorUsedError;
}
