import 'dart:convert';

class Utf8Decoder {
  static String utf8Decode(String text) {
    return utf8.decode(text.runes.toList());
  }
}
