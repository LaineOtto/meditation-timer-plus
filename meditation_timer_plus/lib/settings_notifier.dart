import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_state.dart';

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState.initial());

  void toggleTimerStartsDnD(bool isChecked){
    state = state.copyWith(timerStartsDnD: isChecked);
    print(state);
  }
  void toggleOverrideSystemSound(bool isChecked){
    state = state.copyWith(overrideSystemSound: isChecked);
    print(state);
  }
  void togglePlaySoundOnEachTimer(bool isChecked){
    state = state.copyWith(playSoundOnEachTimer: isChecked);
    print(state);
  }
  void toggleSilenceRinger(bool isChecked){
    state = state.copyWith(silenceRinger: isChecked);
    print(state);
  }
}