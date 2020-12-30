import 'dart:async';

import 'package:rxdart/rxdart.dart';

class InputAuthBloc {
  bool isValid = false;
  var _inputController = BehaviorSubject<String>();
  Stream<String> get inputStream =>
      _inputController.stream.transform(transformer);
  StreamSink<String> get inputSink => _inputController.sink;

// ignore: top_level_function_literal_block
  final transformer = StreamTransformer<String, String>.fromHandlers(
      // ignore: top_level_function_literal_block
      handleData: (value, sink) {
    if (value.length > 20) {
      sink.addError('cant accept anything more than 20');
    } else {
      sink.add(value);
    }
  });
  dispose() {
    _inputController.close();
  }
}
