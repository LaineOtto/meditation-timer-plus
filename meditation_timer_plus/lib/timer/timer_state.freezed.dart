// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TimerState {
  bool get isRunning => throw _privateConstructorUsedError;
  Duration get stopwatchElapsed => throw _privateConstructorUsedError;
  Duration get countdownRemaining => throw _privateConstructorUsedError;
  Duration get countdownInitial => throw _privateConstructorUsedError;
  List<Duration> get countdownQueue => throw _privateConstructorUsedError;
  TimerMode get currentMode => throw _privateConstructorUsedError;
  IconData get currentIcon => throw _privateConstructorUsedError;

  /// Create a copy of TimerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimerStateCopyWith<TimerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerStateCopyWith<$Res> {
  factory $TimerStateCopyWith(
    TimerState value,
    $Res Function(TimerState) then,
  ) = _$TimerStateCopyWithImpl<$Res, TimerState>;
  @useResult
  $Res call({
    bool isRunning,
    Duration stopwatchElapsed,
    Duration countdownRemaining,
    Duration countdownInitial,
    List<Duration> countdownQueue,
    TimerMode currentMode,
    IconData currentIcon,
  });
}

/// @nodoc
class _$TimerStateCopyWithImpl<$Res, $Val extends TimerState>
    implements $TimerStateCopyWith<$Res> {
  _$TimerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRunning = null,
    Object? stopwatchElapsed = null,
    Object? countdownRemaining = null,
    Object? countdownInitial = null,
    Object? countdownQueue = null,
    Object? currentMode = null,
    Object? currentIcon = null,
  }) {
    return _then(
      _value.copyWith(
            isRunning: null == isRunning
                ? _value.isRunning
                : isRunning // ignore: cast_nullable_to_non_nullable
                      as bool,
            stopwatchElapsed: null == stopwatchElapsed
                ? _value.stopwatchElapsed
                : stopwatchElapsed // ignore: cast_nullable_to_non_nullable
                      as Duration,
            countdownRemaining: null == countdownRemaining
                ? _value.countdownRemaining
                : countdownRemaining // ignore: cast_nullable_to_non_nullable
                      as Duration,
            countdownInitial: null == countdownInitial
                ? _value.countdownInitial
                : countdownInitial // ignore: cast_nullable_to_non_nullable
                      as Duration,
            countdownQueue: null == countdownQueue
                ? _value.countdownQueue
                : countdownQueue // ignore: cast_nullable_to_non_nullable
                      as List<Duration>,
            currentMode: null == currentMode
                ? _value.currentMode
                : currentMode // ignore: cast_nullable_to_non_nullable
                      as TimerMode,
            currentIcon: null == currentIcon
                ? _value.currentIcon
                : currentIcon // ignore: cast_nullable_to_non_nullable
                      as IconData,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimerStateImplCopyWith<$Res>
    implements $TimerStateCopyWith<$Res> {
  factory _$$TimerStateImplCopyWith(
    _$TimerStateImpl value,
    $Res Function(_$TimerStateImpl) then,
  ) = __$$TimerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isRunning,
    Duration stopwatchElapsed,
    Duration countdownRemaining,
    Duration countdownInitial,
    List<Duration> countdownQueue,
    TimerMode currentMode,
    IconData currentIcon,
  });
}

/// @nodoc
class __$$TimerStateImplCopyWithImpl<$Res>
    extends _$TimerStateCopyWithImpl<$Res, _$TimerStateImpl>
    implements _$$TimerStateImplCopyWith<$Res> {
  __$$TimerStateImplCopyWithImpl(
    _$TimerStateImpl _value,
    $Res Function(_$TimerStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRunning = null,
    Object? stopwatchElapsed = null,
    Object? countdownRemaining = null,
    Object? countdownInitial = null,
    Object? countdownQueue = null,
    Object? currentMode = null,
    Object? currentIcon = null,
  }) {
    return _then(
      _$TimerStateImpl(
        isRunning: null == isRunning
            ? _value.isRunning
            : isRunning // ignore: cast_nullable_to_non_nullable
                  as bool,
        stopwatchElapsed: null == stopwatchElapsed
            ? _value.stopwatchElapsed
            : stopwatchElapsed // ignore: cast_nullable_to_non_nullable
                  as Duration,
        countdownRemaining: null == countdownRemaining
            ? _value.countdownRemaining
            : countdownRemaining // ignore: cast_nullable_to_non_nullable
                  as Duration,
        countdownInitial: null == countdownInitial
            ? _value.countdownInitial
            : countdownInitial // ignore: cast_nullable_to_non_nullable
                  as Duration,
        countdownQueue: null == countdownQueue
            ? _value._countdownQueue
            : countdownQueue // ignore: cast_nullable_to_non_nullable
                  as List<Duration>,
        currentMode: null == currentMode
            ? _value.currentMode
            : currentMode // ignore: cast_nullable_to_non_nullable
                  as TimerMode,
        currentIcon: null == currentIcon
            ? _value.currentIcon
            : currentIcon // ignore: cast_nullable_to_non_nullable
                  as IconData,
      ),
    );
  }
}

/// @nodoc

class _$TimerStateImpl with DiagnosticableTreeMixin implements _TimerState {
  const _$TimerStateImpl({
    required this.isRunning,
    required this.stopwatchElapsed,
    required this.countdownRemaining,
    required this.countdownInitial,
    required final List<Duration> countdownQueue,
    required this.currentMode,
    required this.currentIcon,
  }) : _countdownQueue = countdownQueue;

  @override
  final bool isRunning;
  @override
  final Duration stopwatchElapsed;
  @override
  final Duration countdownRemaining;
  @override
  final Duration countdownInitial;
  final List<Duration> _countdownQueue;
  @override
  List<Duration> get countdownQueue {
    if (_countdownQueue is EqualUnmodifiableListView) return _countdownQueue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_countdownQueue);
  }

  @override
  final TimerMode currentMode;
  @override
  final IconData currentIcon;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimerState(isRunning: $isRunning, stopwatchElapsed: $stopwatchElapsed, countdownRemaining: $countdownRemaining, countdownInitial: $countdownInitial, countdownQueue: $countdownQueue, currentMode: $currentMode, currentIcon: $currentIcon)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimerState'))
      ..add(DiagnosticsProperty('isRunning', isRunning))
      ..add(DiagnosticsProperty('stopwatchElapsed', stopwatchElapsed))
      ..add(DiagnosticsProperty('countdownRemaining', countdownRemaining))
      ..add(DiagnosticsProperty('countdownInitial', countdownInitial))
      ..add(DiagnosticsProperty('countdownQueue', countdownQueue))
      ..add(DiagnosticsProperty('currentMode', currentMode))
      ..add(DiagnosticsProperty('currentIcon', currentIcon));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerStateImpl &&
            (identical(other.isRunning, isRunning) ||
                other.isRunning == isRunning) &&
            (identical(other.stopwatchElapsed, stopwatchElapsed) ||
                other.stopwatchElapsed == stopwatchElapsed) &&
            (identical(other.countdownRemaining, countdownRemaining) ||
                other.countdownRemaining == countdownRemaining) &&
            (identical(other.countdownInitial, countdownInitial) ||
                other.countdownInitial == countdownInitial) &&
            const DeepCollectionEquality().equals(
              other._countdownQueue,
              _countdownQueue,
            ) &&
            (identical(other.currentMode, currentMode) ||
                other.currentMode == currentMode) &&
            (identical(other.currentIcon, currentIcon) ||
                other.currentIcon == currentIcon));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isRunning,
    stopwatchElapsed,
    countdownRemaining,
    countdownInitial,
    const DeepCollectionEquality().hash(_countdownQueue),
    currentMode,
    currentIcon,
  );

  /// Create a copy of TimerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerStateImplCopyWith<_$TimerStateImpl> get copyWith =>
      __$$TimerStateImplCopyWithImpl<_$TimerStateImpl>(this, _$identity);
}

abstract class _TimerState implements TimerState {
  const factory _TimerState({
    required final bool isRunning,
    required final Duration stopwatchElapsed,
    required final Duration countdownRemaining,
    required final Duration countdownInitial,
    required final List<Duration> countdownQueue,
    required final TimerMode currentMode,
    required final IconData currentIcon,
  }) = _$TimerStateImpl;

  @override
  bool get isRunning;
  @override
  Duration get stopwatchElapsed;
  @override
  Duration get countdownRemaining;
  @override
  Duration get countdownInitial;
  @override
  List<Duration> get countdownQueue;
  @override
  TimerMode get currentMode;
  @override
  IconData get currentIcon;

  /// Create a copy of TimerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimerStateImplCopyWith<_$TimerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
