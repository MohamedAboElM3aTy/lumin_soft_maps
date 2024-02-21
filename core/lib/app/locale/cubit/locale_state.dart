import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_state.freezed.dart';

@freezed
class LocaleState with _$LocaleState {
  const factory LocaleState.initial() = _Initial;

  const factory LocaleState.loading() = Loading;

  const factory LocaleState.changeState() = ChangeState;

  const factory LocaleState.changed({required Locale locale}) = Changed;

  const factory LocaleState.errorState() = ErrorState;
}
