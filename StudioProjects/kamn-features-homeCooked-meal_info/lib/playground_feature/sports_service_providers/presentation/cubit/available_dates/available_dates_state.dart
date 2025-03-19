// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

enum AvailableDatesStatus {
  initial,
  loading,
  success,
  failure,
  intervalsCalc,
  intervalSelected
}

extension SportsGroundStateExtension on AvailableDatesState {
  bool get isInitial => state == AvailableDatesStatus.initial;
  bool get isLoading => state == AvailableDatesStatus.loading;
  bool get isSuccess => state == AvailableDatesStatus.success;
  bool get isFailure => state == AvailableDatesStatus.failure;
  bool get isIntervalsClac => state == AvailableDatesStatus.intervalsCalc;
  bool get isIntervalSelected => state == AvailableDatesStatus.intervalSelected;
}

class AvailableDatesState {
  final AvailableDatesStatus state;
  TimeOfDay? startAt;
  TimeOfDay? endAt;
  List<DateTime>? intervials;
  int period;
  final String? erorrMessage;
  final String? successMessage;

  AvailableDatesState({
    required this.state,
    this.erorrMessage,
    this.endAt,
    this.intervials,
    this.startAt,
    this.period = 60,
    this.successMessage,
  });
  AvailableDatesState copyWith({
    AvailableDatesStatus? state,
    TimeOfDay? startAt,
    TimeOfDay? endAt,
    List<DateTime>? intervials,
    int? peroid,
    String? erorrMessage,
    String? successMessage,
  }) {
    return AvailableDatesState(
      state: state ?? this.state,
      erorrMessage: erorrMessage ?? this.erorrMessage,
      startAt: startAt ?? this.startAt,
      intervials: intervials ?? this.intervials,
      period: peroid ?? period,
      endAt: endAt ?? this.endAt,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  String toString() {
    return 'AvailableDatesState(state: $state, startAt: $startAt, endAt: $endAt, intervials: $intervials, period: $period, erorrMessage: $erorrMessage, successMessage: $successMessage)';
  }
}
