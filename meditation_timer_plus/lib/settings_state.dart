import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required bool timerStartsDnD,
    required double soundVolume,
    required bool overrideSystemVolume,
    required bool playSoundOnEachTimer,
    required bool silenceRinger,
    required double volumeOverrideValue,
    required bool runWithScreenOff,
  }) = _SettingsState;

  factory SettingsState.initial() => const SettingsState(
    timerStartsDnD: true,
    soundVolume: 0.0,
    overrideSystemVolume: true,
    playSoundOnEachTimer: true,
    silenceRinger: true,
    volumeOverrideValue: 0,
    runWithScreenOff: true,
  );
}
