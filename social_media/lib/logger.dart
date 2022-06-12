import 'dart:io' as io;

import 'package:logger/logger.dart';

late Logger _logger;

final printer = PrettyPrinter(
  methodCount: 4,
  errorMethodCount: 8,
  lineLength: 120,
  colors: io.stdout.supportsAnsiEscapes,
  printEmojis: true,
  printTime: true,
);

loggerInitialize({Level level = Level.debug}) {
  Logger.level = level;
  _logger = Logger(printer: PrefixPrinter(printer));
}

Logger get logger => _logger;
