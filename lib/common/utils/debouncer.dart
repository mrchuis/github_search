import 'dart:async';
import 'dart:ui';

class Debouncer {
  static Timer? _timer;

  static run(VoidCallback action, {int milliseconds = 500}) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
