class Debouncer {

  final int milliseconds;
  int _last = 0;

  Debouncer({required this.milliseconds});

  debounce(Function function) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - _last < milliseconds) {
      return;
    }
    function();
    _last = now;
  }
}