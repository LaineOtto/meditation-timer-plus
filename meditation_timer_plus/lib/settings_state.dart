import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required bool timerStartsDnD,
    required double soundVolume,
    required bool overrideSystemSound,
    required bool playSoundOnEachTimer,
    required bool silenceRinger,
  }) = _SettingsState;

  factory SettingsState.initial() => const SettingsState(
    timerStartsDnD: true,
    soundVolume: 0.0,
    overrideSystemSound: true,
    playSoundOnEachTimer: true,
    silenceRinger: true,
  );
}
