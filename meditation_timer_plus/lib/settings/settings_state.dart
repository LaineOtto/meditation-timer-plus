import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required bool timerStartsDnD,
    required bool overrideSystemVolume,
    required bool silenceRinger,
    required double volumeOverrideValue,
    required bool runWithScreenOff,
  }) = _SettingsState;

  factory SettingsState.initial() => const SettingsState(
    timerStartsDnD: true,
    overrideSystemVolume: true,
    silenceRinger: true,
    volumeOverrideValue: 0,
    runWithScreenOff: true,
  );

  factory SettingsState.fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json); 
}
