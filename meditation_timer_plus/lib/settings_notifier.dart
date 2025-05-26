import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_state.dart';

enum TimerSetting {
  timerStartsDnD,
  overrideSystemSound,
  playSoundOnEachTimer,
  silenceRinger,
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState.initial());

  void toggleTimerSettings (TimerSetting setting, bool isChecked) {
    state = switch (setting) {
      TimerSetting.timerStartsDnD => state.copyWith(timerStartsDnD: isChecked),
      TimerSetting.overrideSystemSound => state.copyWith(overrideSystemSound: isChecked),
      TimerSetting.playSoundOnEachTimer => state.copyWith(playSoundOnEachTimer: isChecked),
      TimerSetting.silenceRinger => state.copyWith(silenceRinger: isChecked),
    };
    print(state);
  }

  void setVolumeOverrideValue (double value) {
    state = state.copyWith(volumeOverrideValue: value);
  }
}