import 'dart:async';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

import 'timer_state.dart';

@pragma('vm:entry-point')
Future<void> alarmCallback() async {
  print("alarm called");

  final timerSoundPlayer = AudioPlayer();
  await timerSoundPlayer.play(AssetSource("gong.wav"));
}

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier() : super(TimerState.initial()) {
    _stopwatchElapsed = Stopwatch();
  }

  late Stopwatch _stopwatchElapsed;
  Timer? _stopwatchTicker;
  Timer? _countdownTimer;
  bool _isFirstRun = true;

  void updateInitialDuration(Duration duration) {
    _isFirstRun = false;
    state = state.copyWith(
      countdownRemaining: duration,
      countdownInitial: duration,
      countdownQueue: [],
      currentMode: TimerMode.single,
    );
  }

  Future<void> scheduleAlarm(Duration after) async {
    final alarmId = 0;
    await AndroidAlarmManager.oneShot(
      after,
      alarmId,
      alarmCallback,
      allowWhileIdle: true,
      rescheduleOnReboot: true,
      wakeup: true,
    );
  }

  void _advanceQueue() {
    Duration countdownRemaining = state.countdownQueue.first;
    state = state.copyWith(
      currentMode: TimerMode.queue,
      countdownRemaining: countdownRemaining,
      countdownQueue: List.from(state.countdownQueue)..removeAt(0),
    );
  }

  void _setCountdownWithoutQueue(Duration countdownRemaining) {
    state = state.copyWith(
      currentMode: TimerMode.single,
      countdownRemaining: countdownRemaining,
      countdownQueue: [],
    );
  }

  void _useDefaultCountdown() {
    Duration countdownRemaining = Duration(seconds: 30);
    state = state.copyWith(
      currentMode: TimerMode.single,
      countdownRemaining: countdownRemaining,
    );
  }

  void _prepareInitialCountdown() {
    Duration countdownRemaining = state.countdownRemaining;
    _isFirstRun = false;
    if (state.countdownQueue.isNotEmpty) {
      _advanceQueue();
    } else if (countdownRemaining > Duration.zero) {
      _setCountdownWithoutQueue(countdownRemaining);
    } else {
      _useDefaultCountdown();
    }
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _tickTimer(timer);
    });

    state = state.copyWith(
      isRunning: true,
      currentIcon: Icons.pause_circle_filled,
    );
  }

  void _initializeStopwatch() {
    _stopwatchElapsed.start();
    _stopwatchTicker?.cancel();
    _stopwatchTicker = Timer.periodic(Duration(seconds: 1), (_) {
      if (_stopwatchElapsed.isRunning) {
        state = state.copyWith(stopwatchElapsed: _stopwatchElapsed.elapsed);
      }
    });
  }

  void startTimers() {
    if (state.isRunning) return;

    updateInitialDuration(state.countdownRemaining);

    _initializeStopwatch();
    _prepareInitialCountdown();
    _startCountdownTimer();

    scheduleAlarm(state.countdownRemaining);
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
      onTimerFinish();
    }
  }

  void pauseTimers() {
    _stopwatchElapsed.stop();
    _countdownTimer?.cancel();
    _stopwatchTicker?.cancel();

    state = state.copyWith(
      isRunning: false,
      currentIcon: Icons.play_circle_fill,
    );
  }

  void resetTimers() {
    _stopwatchElapsed.stop();
    _stopwatchElapsed.reset();
    _countdownTimer?.cancel();
    _stopwatchTicker?.cancel();
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

  Future<void> onTimerFinish() async {
    print("timer finish");
    _countdownTimer?.cancel();
    state = state.copyWith(
      countdownRemaining: Duration(seconds: 0),
      countdownQueue: [],
    );
  }
}
