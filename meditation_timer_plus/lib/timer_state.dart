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
    required List<Duration> countdownQueue,
    required TimerMode currentMode,
    required IconData currentIcon,
  }) = _TimerState;

  factory TimerState.initial() => const TimerState(
    isRunning: false,
    stopwatchElapsed: Duration.zero,
    countdownRemaining: Duration(seconds: 30),
    countdownQueue: [],
    currentMode: TimerMode.single,
    currentIcon: Icons.play_circle_fill,
  );
}



// class TimerState {
//   final bool isRunning;
//   final Duration stopwatchElapsed;
//   final Duration countdownRemaining;
//   final List<Duration> countdownQueue;
//   final TimerMode currentMode;
//   final IconData currentIcon;

//   TimerState({
//     required this.isRunning,
//     required this.stopwatchElapsed,
//     required this.countdownRemaining,
//     required this.countdownQueue,
//     required this.currentMode,
//     required this.currentIcon,
//   });

//   TimerState copyWith({
//     bool? isRunning,
//     Duration? stopwatchElapsed,
//     Duration? countdownRemaining,
//     List<Duration>? countdownQueue,
//     TimerMode? currentMode,
//     IconData? currentIcon,
//   }) {
//     return TimerState(
//       isRunning: isRunning ?? this.isRunning,
//       stopwatchElapsed: stopwatchElapsed ?? this.stopwatchElapsed,
//       countdownRemaining: countdownRemaining ?? this.countdownRemaining,
//       countdownQueue: countdownQueue ?? this.countdownQueue,
//       currentMode: currentMode ?? this.currentMode,
//       currentIcon: currentIcon ?? this.currentIcon,
//     );
//   }

//   factory TimerState.initial() => TimerState(
//     isRunning: false,
//     stopwatchElapsed: Duration.zero,
//     countdownRemaining: Duration(seconds: 30),
//     countdownQueue: [],
//     currentMode: TimerMode.single,
//     currentIcon: Icons.play_circle_fill,
//   );
// }