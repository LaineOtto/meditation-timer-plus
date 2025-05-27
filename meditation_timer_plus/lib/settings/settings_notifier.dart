import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_state.dart';
import 'platform_settings_service.dart';

enum TimerSetting {
  timerStartsDnD,
  overrideSystemVolume,
  silenceRinger,
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier(this._platformSettingsService) : super(SettingsState.initial());

  final PlatformSettingsService _platformSettingsService;

  void toggleTimerSettings(TimerSetting setting, bool isChecked) {
    state = switch (setting) {
      TimerSetting.timerStartsDnD => state.copyWith(timerStartsDnD: isChecked),
      TimerSetting.overrideSystemVolume => state.copyWith(
        overrideSystemVolume: isChecked,
      ),
      TimerSetting.silenceRinger => state.copyWith(silenceRinger: isChecked),
    };
    print(state);
  }

  void setVolumeOverrideValue(double value) {
    state = state.copyWith(volumeOverrideValue: value);
  }

  Future<void> handleTimerSettingsOnStart() async {
    if (state.overrideSystemVolume) {
      await _platformSettingsService.setSystemVolumeToOverrideVolume(state.volumeOverrideValue);
    }
    if (state.timerStartsDnD) {
      await _platformSettingsService.enableDnD();
    }
    if (state.silenceRinger) {
      await _platformSettingsService.silenceRinger();
    }
  }
}
