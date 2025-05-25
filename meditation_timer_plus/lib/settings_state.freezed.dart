// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SettingsState {
  bool get timerStartsDnD => throw _privateConstructorUsedError;
  double get soundVolume => throw _privateConstructorUsedError;
  bool get overrideSystemSound => throw _privateConstructorUsedError;
  bool get playSoundOnEachTimer => throw _privateConstructorUsedError;
  bool get silenceRinger => throw _privateConstructorUsedError;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
    SettingsState value,
    $Res Function(SettingsState) then,
  ) = _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call({
    bool timerStartsDnD,
    double soundVolume,
    bool overrideSystemSound,
    bool playSoundOnEachTimer,
    bool silenceRinger,
  });
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timerStartsDnD = null,
    Object? soundVolume = null,
    Object? overrideSystemSound = null,
    Object? playSoundOnEachTimer = null,
    Object? silenceRinger = null,
  }) {
    return _then(
      _value.copyWith(
            timerStartsDnD: null == timerStartsDnD
                ? _value.timerStartsDnD
                : timerStartsDnD // ignore: cast_nullable_to_non_nullable
                      as bool,
            soundVolume: null == soundVolume
                ? _value.soundVolume
                : soundVolume // ignore: cast_nullable_to_non_nullable
                      as double,
            overrideSystemSound: null == overrideSystemSound
                ? _value.overrideSystemSound
                : overrideSystemSound // ignore: cast_nullable_to_non_nullable
                      as bool,
            playSoundOnEachTimer: null == playSoundOnEachTimer
                ? _value.playSoundOnEachTimer
                : playSoundOnEachTimer // ignore: cast_nullable_to_non_nullable
                      as bool,
            silenceRinger: null == silenceRinger
                ? _value.silenceRinger
                : silenceRinger // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SettingsStateImplCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$SettingsStateImplCopyWith(
    _$SettingsStateImpl value,
    $Res Function(_$SettingsStateImpl) then,
  ) = __$$SettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool timerStartsDnD,
    double soundVolume,
    bool overrideSystemSound,
    bool playSoundOnEachTimer,
    bool silenceRinger,
  });
}

/// @nodoc
class __$$SettingsStateImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsStateImpl>
    implements _$$SettingsStateImplCopyWith<$Res> {
  __$$SettingsStateImplCopyWithImpl(
    _$SettingsStateImpl _value,
    $Res Function(_$SettingsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timerStartsDnD = null,
    Object? soundVolume = null,
    Object? overrideSystemSound = null,
    Object? playSoundOnEachTimer = null,
    Object? silenceRinger = null,
  }) {
    return _then(
      _$SettingsStateImpl(
        timerStartsDnD: null == timerStartsDnD
            ? _value.timerStartsDnD
            : timerStartsDnD // ignore: cast_nullable_to_non_nullable
                  as bool,
        soundVolume: null == soundVolume
            ? _value.soundVolume
            : soundVolume // ignore: cast_nullable_to_non_nullable
                  as double,
        overrideSystemSound: null == overrideSystemSound
            ? _value.overrideSystemSound
            : overrideSystemSound // ignore: cast_nullable_to_non_nullable
                  as bool,
        playSoundOnEachTimer: null == playSoundOnEachTimer
            ? _value.playSoundOnEachTimer
            : playSoundOnEachTimer // ignore: cast_nullable_to_non_nullable
                  as bool,
        silenceRinger: null == silenceRinger
            ? _value.silenceRinger
            : silenceRinger // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SettingsStateImpl implements _SettingsState {
  const _$SettingsStateImpl({
    required this.timerStartsDnD,
    required this.soundVolume,
    required this.overrideSystemSound,
    required this.playSoundOnEachTimer,
    required this.silenceRinger,
  });

  @override
  final bool timerStartsDnD;
  @override
  final double soundVolume;
  @override
  final bool overrideSystemSound;
  @override
  final bool playSoundOnEachTimer;
  @override
  final bool silenceRinger;

  @override
  String toString() {
    return 'SettingsState(timerStartsDnD: $timerStartsDnD, soundVolume: $soundVolume, overrideSystemSound: $overrideSystemSound, playSoundOnEachTimer: $playSoundOnEachTimer, silenceRinger: $silenceRinger)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsStateImpl &&
            (identical(other.timerStartsDnD, timerStartsDnD) ||
                other.timerStartsDnD == timerStartsDnD) &&
            (identical(other.soundVolume, soundVolume) ||
                other.soundVolume == soundVolume) &&
            (identical(other.overrideSystemSound, overrideSystemSound) ||
                other.overrideSystemSound == overrideSystemSound) &&
            (identical(other.playSoundOnEachTimer, playSoundOnEachTimer) ||
                other.playSoundOnEachTimer == playSoundOnEachTimer) &&
            (identical(other.silenceRinger, silenceRinger) ||
                other.silenceRinger == silenceRinger));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    timerStartsDnD,
    soundVolume,
    overrideSystemSound,
    playSoundOnEachTimer,
    silenceRinger,
  );

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      __$$SettingsStateImplCopyWithImpl<_$SettingsStateImpl>(this, _$identity);
}

abstract class _SettingsState implements SettingsState {
  const factory _SettingsState({
    required final bool timerStartsDnD,
    required final double soundVolume,
    required final bool overrideSystemSound,
    required final bool playSoundOnEachTimer,
    required final bool silenceRinger,
  }) = _$SettingsStateImpl;

  @override
  bool get timerStartsDnD;
  @override
  double get soundVolume;
  @override
  bool get overrideSystemSound;
  @override
  bool get playSoundOnEachTimer;
  @override
  bool get silenceRinger;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
