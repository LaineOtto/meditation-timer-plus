import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';

import 'settings_state.dart';

enum TimerSetting {
  timerStartsDnD,
  overrideSystemVolume,
  playSoundOnEachTimer,
  silenceRinger,
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState.initial());

  void toggleTimerSettings (TimerSetting setting, bool isChecked) {
    state = switch (setting) {
      TimerSetting.timerStartsDnD => state.copyWith(timerStartsDnD: isChecked),
      TimerSetting.overrideSystemVolume => state.copyWith(overrideSystemVolume: isChecked),
      TimerSetting.playSoundOnEachTimer => state.copyWith(playSoundOnEachTimer: isChecked),
      TimerSetting.silenceRinger => state.copyWith(silenceRinger: isChecked),
    };
    print(state);
  }

  void handleTimerSettingsOnStart() {
    if (state.overrideSystemVolume == true) {
      overrideVolume(state.volumeOverrideValue);
    }
    // if (state.timerStartsDnD == true) {
    //   enableDnD();
    // }
  }

   void setVolumeOverrideValue (double value) {
    state = state.copyWith(volumeOverrideValue: value);
  }

  Future<void> overrideVolume (double value) async {
    await FlutterVolumeController.updateShowSystemUI(true); //TODO: set as false once testing is done for uix purposes
    await FlutterVolumeController.setVolume(state.volumeOverrideValue, stream: AudioStream.music);
  }

  Future<void> silenceRinger (double value) async {
    await FlutterVolumeController.updateShowSystemUI(true); //TODO: set as false once testing is done for uix purposes
    await FlutterVolumeController.setVolume(0, stream: AudioStream.ring);
  }
  
  // Future<void> enableDnD () async {
  //   bool accessGranted = (await FlutterDnd.isNotificationPolicyAccessGranted) ?? false;
  //   if (accessGranted) {
  //     await FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE); // Turn on DND - All notifications are suppressed.
  //   } else {
  //     FlutterDnd.gotoPolicySettings();
  //   }
  // }


}