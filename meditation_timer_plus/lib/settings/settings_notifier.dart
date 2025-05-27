import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'settings_state.dart';
import 'platform_settings_service.dart';

enum TimerSetting { timerStartsDnD, overrideSystemVolume, silenceRinger }

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier(this._platformSettingsService)
    : super(SettingsState.initial());

  final PlatformSettingsService _platformSettingsService;

  Future<void> saveToPrefs() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setString('settingsState', jsonEncode(state.toJson()));
  }

  Future<void> loadFromPrefs() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    final savedStateJsonString = await prefs.getString('settingsState');
    if (savedStateJsonString != null) {
      final savedStateJson = jsonDecode(savedStateJsonString);
      state = SettingsState.fromJson(savedStateJson);
    }
  }

  void toggleTimerSettings(TimerSetting setting, bool isChecked) {
    state = switch (setting) {
      TimerSetting.timerStartsDnD => state.copyWith(timerStartsDnD: isChecked),
      TimerSetting.overrideSystemVolume => state.copyWith(
        overrideSystemVolume: isChecked,
      ),
      TimerSetting.silenceRinger => state.copyWith(silenceRinger: isChecked),
    };
    saveToPrefs();
    print(state);
  }

  void setVolumeOverrideValue(double value) {
    state = state.copyWith(volumeOverrideValue: value);
    saveToPrefs();
  }

  Future<void> handleTimerSettingsOnStart() async {
    if (state.overrideSystemVolume) {
      await _platformSettingsService.setSystemVolumeToOverrideVolume(
        state.volumeOverrideValue,
      );
    }
    if (state.timerStartsDnD) {
      await _platformSettingsService.enableDnD();
    }
    if (state.silenceRinger) {
      await _platformSettingsService.silenceRinger();
    }
  }
}
