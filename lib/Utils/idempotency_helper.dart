import 'package:uuid/uuid.dart';

class IdempotencyHelper {
  static String generateKey() {
    return const Uuid().v4();
  }
}