import 'dart:math';

String objectId() {
  var h = 16;
  s(double seconds) => (seconds.floor()).toRadixString(h);

  var now = DateTime.now().millisecondsSinceEpoch / 1000;
  var randomChars =
      List.filled(h, ' ').map((char) => s(Random().nextDouble() * h)).join('');

  return s(now) + randomChars;
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

String enumToString(Enum? obj) {
  // print(obj);
  if (obj == null) return '';
  return obj.name;
}

// only to be used internally by amplify-flutter library
T? enumFromString<T extends Enum>(String? key, List<T> values) {
  try {
    if (key == null || key == '') return null;
    return values.firstWhere((v) => key.trim() == enumToString(v));
  } catch (e) {
    return null;
  }
}

/// check whether an dynamic type [value] is an enum
bool isEnum(dynamic value) {
  final split = value.toString().split('.');
  return split.length > 1 && split[0] == value.runtimeType.toString();
}
