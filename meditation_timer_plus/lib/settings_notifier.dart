import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_state.dart';

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState.initial());

  void toggleTimerStartsDnD(bool isChecked){
    state = state.copyWith(timerStartsDnD: isChecked);
    print(state);
  }
}