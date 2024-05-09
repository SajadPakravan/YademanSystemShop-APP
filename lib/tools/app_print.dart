import 'package:flutter/foundation.dart';

log(String message) {
  if (kDebugMode) {
    return print(message);
  }
}
