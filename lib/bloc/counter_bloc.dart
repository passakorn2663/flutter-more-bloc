import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0, false));

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is IncreaseEvent) {
      yield state.copyWith(value: state.value + 1);
    } else if (event is InitialEvent) {
      yield state.copyWith(value: await fetchInitialValue());
    } else if (event is SaveEvent) {
      yield state.copyWith(isSaving: true);
      await saveValue(event.value);
      yield state.copyWith(isSaving: false);
    }
  }

  Future<int> fetchInitialValue() async {
    final resp = await http.get('http://localhost:3000/count');
    var json = jsonDecode(resp.body);
    return json['value'] as int;
  }

  Future<int> saveValue(int value) async {
    final resp = await http.post('http://localhost:3000/count',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"value": value}));
    var json = jsonDecode(resp.body);
    return json['ok'] as int;
  }
}
