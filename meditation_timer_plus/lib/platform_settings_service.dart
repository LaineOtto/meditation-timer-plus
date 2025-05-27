import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:do_not_disturb/do_not_disturb.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class PlatformSettingsService {
  Future<void> setSystemVolumeToOverrideVolume(double value) async {
    await FlutterVolumeController.updateShowSystemUI(
      false,
    ); //TODO: set as false once testing is done for uix purposes
    await FlutterVolumeController.setVolume(value, stream: AudioStream.music);
  }

  final dndPlugin = DoNotDisturbPlugin();
  Future<bool> _checkNotificationPolicyAccess() async {
    bool accessGranted = await dndPlugin.isNotificationPolicyAccessGranted();
    if (accessGranted) {
      return true;
    } else {
      await dndPlugin.openNotificationPolicyAccessSettings();
      return false;
    }
  }

  Future<void> enableDnD() async {
    bool isDnDEnabled = await _checkNotificationPolicyAccess();
    if (isDnDEnabled) {
      await dndPlugin.setInterruptionFilter(InterruptionFilter.alarms);
    }
  }

  Future<void> silenceRinger() async {
    bool isDnDEnabled = await _checkNotificationPolicyAccess();
    if (isDnDEnabled) {
      await SoundMode.setSoundMode(RingerModeStatus.silent);
    }
  }
}
