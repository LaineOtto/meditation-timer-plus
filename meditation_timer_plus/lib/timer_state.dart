import 'package:flutter/material.dart';

enum TimerMode { single, queue }

class TimerState {
  final bool isRunning;
  final Duration stopwatchElapsed;
  final Duration countdownRemaining;
  final List<Duration> countdownQueue;
  final TimerMode currentMode;
  final IconData currentIcon;

  TimerState({
    required this.isRunning,
    required this.stopwatchElapsed,
    required this.countdownRemaining,
    required this.countdownQueue,
    required this.currentMode,
    required this.currentIcon,
  });

  TimerState copyWith({
    bool? isRunning,
    Duration? stopwatchElapsed,
    Duration? countdownRemaining,
    List<Duration>? countdownQueue,
    TimerMode? currentMode,
    IconData? currentIcon,
  }) {
    return TimerState(
      isRunning: isRunning ?? this.isRunning,
      stopwatchElapsed: stopwatchElapsed ?? this.stopwatchElapsed,
      countdownRemaining: countdownRemaining ?? this.countdownRemaining,
      countdownQueue: countdownQueue ?? this.countdownQueue,
      currentMode: currentMode ?? this.currentMode,
      currentIcon: currentIcon ?? this.currentIcon,
    );
  }

  factory TimerState.initial() => TimerState(
    isRunning: false,
    stopwatchElapsed: Duration.zero,
    countdownRemaining: Duration(seconds: 30),
    countdownQueue: [],
    currentMode: TimerMode.single,
    currentIcon: Icons.play_circle_fill,
  );
}
