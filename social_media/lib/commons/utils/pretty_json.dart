import 'dart:convert';

String prettyJson(Object? object) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  return encoder.convert(object ?? {});
}
