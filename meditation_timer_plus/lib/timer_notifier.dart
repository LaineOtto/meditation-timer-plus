import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'timer_state.dart';

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier() : super(TimerState.initial()) {
    _stopwatch = Stopwatch();
  }

  Stopwatch? _stopwatch;
  Timer? _stopwatchTimer;
  Timer? _countdownTimer;
  bool _isFirstRun = true;

  void updateInitialDuration(Duration duration) {
    _isFirstRun = false;
    state = state.copyWith(
      countdownRemaining: duration,
      countdownQueue: [],
      currentMode: TimerMode.single,
    );
  }

  void startTimers() {
    if (state.isRunning) return;

    _stopwatch ??= Stopwatch();
    _stopwatch!.start();

    _stopwatchTimer?.cancel();
    _stopwatchTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_stopwatch!.isRunning) {
        state = state.copyWith(stopwatchElapsed: _stopwatch!.elapsed);
      }
    });

    Duration countdownRemaining = state.countdownRemaining;

    if (state.countdownQueue.isNotEmpty && _isFirstRun) {
      countdownRemaining = state.countdownQueue.first;
      _isFirstRun = false;
      state = state.copyWith(
        currentMode: TimerMode.queue,
        countdownRemaining: countdownRemaining,
        countdownQueue: List.from(state.countdownQueue)..removeAt(0),
      );

      final immediateRemaining =
          state.countdownRemaining - Duration(seconds: 1);
      if (immediateRemaining > Duration.zero) {
        state = state.copyWith(countdownRemaining: immediateRemaining);
      }
    } else if (_isFirstRun) {
      countdownRemaining = Duration(seconds: 30);
      _isFirstRun = false;
      state = state.copyWith(
        currentMode: TimerMode.single,
        countdownRemaining: countdownRemaining,
      );
    } else {
      if (countdownRemaining <= Duration.zero) {
        countdownRemaining = Duration(seconds: 30);
      }
      state = state.copyWith(
        currentMode: TimerMode.single,
        countdownRemaining: countdownRemaining,
      );
    }

    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _tickTimer(timer);
    });

    state = state.copyWith(
      isRunning: true,
      currentIcon: Icons.pause_circle_filled,
    );
  }

  void _tickTimer(Timer timer) {
    if (state.countdownRemaining > Duration.zero) {
      final newRemaining = state.countdownRemaining - Duration(seconds: 1);
      state = state.copyWith(countdownRemaining: newRemaining);
    } else if (state.currentMode == TimerMode.queue &&
        state.countdownQueue.isNotEmpty) {
      final newQueue = List<Duration>.from(state.countdownQueue);
      final nextDuration = newQueue.removeAt(0);
      state = state.copyWith(
        countdownRemaining: nextDuration,
        countdownQueue: newQueue,
      );
    } else {
      state = state.copyWith(
        countdownRemaining: Duration.zero,
        currentIcon: Icons.play_circle_fill,
        isRunning: false,
      );
      timer.cancel();
    }
  }

  void pauseTimers() {
    _stopwatch?.stop();
    _countdownTimer?.cancel();
    _stopwatchTimer?.cancel();

    state = state.copyWith(
      isRunning: false,
      currentIcon: Icons.play_circle_fill,
    );
  }

  void resetTimers() {
    _stopwatch?.stop();
    _stopwatch?.reset();
    _countdownTimer?.cancel();
    _stopwatchTimer?.cancel();
    _isFirstRun = true;

    state = TimerState.initial();
  }

  void toggleTimers() {
    if (state.isRunning) {
      pauseTimers();
    } else {
      startTimers();
    }
  }

  void setTime(List<Duration> times) {
    _isFirstRun = false;
    resetTimers();
    if (times.isEmpty) return;

    if (times.length == 1) {
      state = state.copyWith(countdownRemaining: times[0]);
    } else {
      state = state.copyWith(
        countdownQueue: List.from(times),
        countdownRemaining: times[0],
      );
    }
  }
}
