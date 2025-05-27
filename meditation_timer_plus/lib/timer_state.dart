import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.freezed.dart';

enum TimerMode { single, queue }

@freezed
class TimerState with _$TimerState {
  const factory TimerState({
    required bool isRunning,
    required Duration stopwatchElapsed,
    required Duration countdownRemaining,
    required Duration countdownInitial,
    required List<Duration> countdownQueue,
    required TimerMode currentMode,
    required IconData currentIcon,
  }) = _TimerState;

  factory TimerState.initial() => const TimerState(
    isRunning: false,
    stopwatchElapsed: Duration.zero,
    countdownRemaining: Duration(seconds: 10),
    countdownInitial: Duration(seconds: 0),
    countdownQueue: [],
    currentMode: TimerMode.single,
    currentIcon: Icons.play_circle_fill,
  );
}
