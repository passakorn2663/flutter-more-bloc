part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class IncreaseEvent extends CounterEvent {}

class InitialEvent extends CounterEvent {}

class SaveEvent extends CounterEvent {
  SaveEvent(this.value);
  final int value;
}
