import 'dart:math';

class RandomString {
  final _random = Random();
  final _chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

  String nextString({required int length}) {
    return String.fromCharCodes(
      Iterable.generate(length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))),
    );
  }
}
