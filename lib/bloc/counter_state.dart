part of 'counter_bloc.dart';

@immutable
class CounterState {
  CounterState(this.value, this.isSaving);

  final int value;
  final bool isSaving;

  CounterState copyWith({int value, bool isSaving}) {
    return CounterState(value ?? this.value, isSaving ?? this.isSaving);
  }
}
