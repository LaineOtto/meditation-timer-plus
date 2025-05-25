import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required bool setDnDOn,
    required double soundVolume,
    required bool overrideSystemSound,
    required bool playSoundOnEachTimer,
    required bool silenceRinger,
  }) = _SettingsState;

  factory SettingsState.initial() => const SettingsState(
    setDnDOn: false,
    soundVolume: 0.0,
    overrideSystemSound: true,
    playSoundOnEachTimer: true,
    silenceRinger: true,
  );
}
