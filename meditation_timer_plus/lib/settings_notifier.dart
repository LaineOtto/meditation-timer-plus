import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:do_not_disturb/do_not_disturb.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

import 'settings_state.dart';

enum TimerSetting {
  timerStartsDnD,
  overrideSystemVolume,
  silenceRinger,
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState.initial());

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

  void handleTimerSettingsOnStart() {
    if (state.overrideSystemVolume == true) {
      overrideVolume(state.volumeOverrideValue);
    }
    if (state.timerStartsDnD == true) {
      enableDnD();
    }
  }

  void setVolumeOverrideValue(double value) {
    state = state.copyWith(volumeOverrideValue: value);
  }

  Future<void> overrideVolume(double value) async {
    await FlutterVolumeController.updateShowSystemUI(
      false,
    ); //TODO: set as false once testing is done for uix purposes
    await FlutterVolumeController.setVolume(
      value,
      stream: AudioStream.music,
    );
  }

  final dndPlugin = DoNotDisturbPlugin();
  Future<bool> checkNotificationPolicyAccess() async {
    bool accessGranted = await dndPlugin.isNotificationPolicyAccessGranted();
    if (accessGranted) {
      return true;
    } else {
      await dndPlugin.openNotificationPolicyAccessSettings();
      return false;
    }
  }

  Future<void> enableDnD() async {
    bool isDnDEnabled = await checkNotificationPolicyAccess();
    if (isDnDEnabled) {
      await dndPlugin.setInterruptionFilter(InterruptionFilter.alarms);
    }
  }

  Future<void> silenceRinger() async {
    bool isDnDEnabled = await checkNotificationPolicyAccess();
    if (isDnDEnabled) {
      await SoundMode.setSoundMode(RingerModeStatus.silent);
    }
  }
}
