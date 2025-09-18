import 'dart:math';

String newId([String prefix = 'id']) {
  final r = Random();
  final ts = DateTime.now().millisecondsSinceEpoch;
  final rand = r.nextInt(1 << 32).toRadixString(16);
  return '$prefix-$ts-$rand';
}
