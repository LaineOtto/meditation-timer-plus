import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_state.dart';

enum timerSetting {
  timerStartsDnD,
  overrideSystemSound,
  playSoundOnEachTimer,
  silenceRinger,
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState.initial());

  void toggleTimerSettings (timerSetting setting, bool isChecked) {
    state = switch (setting) {
      timerSetting.timerStartsDnD => state.copyWith(timerStartsDnD: isChecked),
      timerSetting.overrideSystemSound => state.copyWith(overrideSystemSound: isChecked),
      timerSetting.playSoundOnEachTimer => state.copyWith(playSoundOnEachTimer: isChecked),
      timerSetting.silenceRinger => state.copyWith(silenceRinger: isChecked),
    };
    print(state);
  }
}