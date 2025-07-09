import 'dart:math';

class RandomString {
  static final _random = Random();
  static const _chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

  /// Returns a random string of [length] (default: 2) using a-zA-Z.
  static String nextString({int length = 2}) {
    return String.fromCharCodes(
      Iterable.generate(length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))),
    );
  }
}
