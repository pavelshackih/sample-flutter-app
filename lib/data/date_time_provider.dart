import 'dart:async';

/// Provider for current [DeviceTime]
abstract class DateTimeProvider {
  Future<DateTime> getNow();
}

/// [DateTime] provider from device
class LocalDateTimeProvider implements DateTimeProvider {
  @override
  Future<DateTime> getNow() async {
    return DateTime.now();
  }
}
