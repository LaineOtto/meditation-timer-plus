// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsStateImpl _$$SettingsStateImplFromJson(Map<String, dynamic> json) =>
    _$SettingsStateImpl(
      timerStartsDnD: json['timerStartsDnD'] as bool,
      overrideSystemVolume: json['overrideSystemVolume'] as bool,
      silenceRinger: json['silenceRinger'] as bool,
      volumeOverrideValue: (json['volumeOverrideValue'] as num).toDouble(),
      runWithScreenOff: json['runWithScreenOff'] as bool,
    );

Map<String, dynamic> _$$SettingsStateImplToJson(_$SettingsStateImpl instance) =>
    <String, dynamic>{
      'timerStartsDnD': instance.timerStartsDnD,
      'overrideSystemVolume': instance.overrideSystemVolume,
      'silenceRinger': instance.silenceRinger,
      'volumeOverrideValue': instance.volumeOverrideValue,
      'runWithScreenOff': instance.runWithScreenOff,
    };
