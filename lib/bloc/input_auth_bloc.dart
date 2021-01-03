import 'dart:async';

import 'package:rxdart/rxdart.dart';

class InputAuthBloc {
  var _inputController = BehaviorSubject<String>();
  Stream<String> get inputStream =>
      _inputController.stream.transform(transformer);
  StreamSink<String> get inputSink => _inputController.sink;

  final transformer = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.length > 50) {
        sink.addError('cant accept anything more than 20');
      } else {
        sink.add(value);
      }
    },
  );

  dispose() {
    _inputController.close();
  }
}
