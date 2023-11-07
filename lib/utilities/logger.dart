import 'package:logger/logger.dart';

class Log {
  static d(dynamic message) {
    final logger = Logger();
    logger.d(message);
  }
}
