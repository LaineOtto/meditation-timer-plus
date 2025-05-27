import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:meditation_timer_plus/timer/timer_notifier.dart';
import 'package:meditation_timer_plus/timer/timer_state.dart';

void main() {
  late TimerNotifier timerNotifier;

  setUp(() {
    timerNotifier = TimerNotifier();
  });

  test('initial state is TimerState.initial', () {
    expect(timerNotifier.state, TimerState.initial());
  });

  test('updateInitialDuration updates countdownRemaining and resets queue', () {
    final duration = Duration(minutes: 5);
    timerNotifier.updateInitialDuration(duration);

    expect(timerNotifier.state.countdownRemaining, duration);
    expect(timerNotifier.state.countdownQueue, isEmpty);
    expect(timerNotifier.state.currentMode, TimerMode.single);
  });

  test('startTimers starts stopwatch and countdown timers (single mode)', () {
    timerNotifier.updateInitialDuration(Duration(seconds: 10));

    fakeAsync((async) {
      timerNotifier.startTimers();

      expect(timerNotifier.state.isRunning, true);
      expect(timerNotifier.state.currentIcon, Icons.pause_circle_filled);
      expect(timerNotifier.state.currentMode, TimerMode.single);
      expect(timerNotifier.state.countdownRemaining.inSeconds <= 10, true);

      // Fast-forward 3 seconds
      async.elapse(Duration(seconds: 3));

      // countdownRemaining should reduce by 3 seconds (or close)
      expect(timerNotifier.state.countdownRemaining.inSeconds, lessThan(10));

      // Stopwatch elapsed should be close to 3 seconds
      expect(timerNotifier.state.stopwatchElapsed.inSeconds, closeTo(3, 1));
    });
  });

  test('pauseTimers stops timers and updates state', () {
    timerNotifier.updateInitialDuration(Duration(seconds: 5));

    fakeAsync((async) {
      timerNotifier.startTimers();

      expect(timerNotifier.state.isRunning, true);

      timerNotifier.pauseTimers();

      expect(timerNotifier.state.isRunning, false);
      expect(timerNotifier.state.currentIcon, Icons.play_circle_fill);

      // Timers should not update state anymore
      async.elapse(Duration(seconds: 5));
      expect(
        timerNotifier.state.countdownRemaining.inSeconds,
        lessThanOrEqualTo(5),
      );
    });
  });

  test('resetTimers resets all state and stopwatch', () {
    timerNotifier.updateInitialDuration(Duration(seconds: 10));

    fakeAsync((async) {
      timerNotifier.startTimers();
      async.elapse(Duration(seconds: 2));

      timerNotifier.resetTimers();

      expect(timerNotifier.state, TimerState.initial());
      expect(timerNotifier.state.isRunning, false);
      expect(timerNotifier.state.countdownRemaining, Duration(seconds: 30));
      expect(timerNotifier.state.stopwatchElapsed, Duration.zero);
    });
  });

  test('toggleTimers calls startTimers and pauseTimers properly', () {
    timerNotifier.updateInitialDuration(Duration(seconds: 10));

    fakeAsync((async) {
      timerNotifier.toggleTimers();
      expect(timerNotifier.state.isRunning, true);

      timerNotifier.toggleTimers();
      expect(timerNotifier.state.isRunning, false);
    });
  });

  test('setTime sets single duration correctly', () {
    timerNotifier.setTime([Duration(seconds: 45)]);

    expect(timerNotifier.state.countdownRemaining, Duration(seconds: 45));
    expect(timerNotifier.state.countdownQueue, isEmpty);
  });

  test('setTime sets queue and countdownRemaining correctly', () {
    final queue = [
      Duration(seconds: 10),
      Duration(seconds: 20),
      Duration(seconds: 30),
    ];
    timerNotifier.setTime(queue);

    expect(timerNotifier.state.countdownRemaining, Duration(seconds: 10));
    expect(timerNotifier.state.countdownQueue, [
      Duration(seconds: 10),
      Duration(seconds: 20),
      Duration(seconds: 30),
    ]);
  });
}
