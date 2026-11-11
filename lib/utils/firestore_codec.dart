/// Firestore stores dates as a Timestamp-like object. Convert that to a plain
/// DateTime without requiring a direct dependency on the cloud_firestore package.
DateTime readDate(Object? value) {
  if (value is DateTime) {
    return DateTime(value.year, value.month, value.day);
  }

  if (value != null) {
    try {
      final dynamic maybeTimestamp = value;
      if (maybeTimestamp.toDate is Function) {
        final date = maybeTimestamp.toDate();
        if (date is DateTime) {
          return DateTime(date.year, date.month, date.day);
        }
      }
    } catch (_) {
      // Ignore non-Timestamp values and fall back to now.
    }
  }

  return DateTime.now();
}

/// Firestore may return whole numbers as int, so convert to double safely.
double readDouble(Object? value) => value is num ? value.toDouble() : 0;

String readString(Object? value, [String fallback = '']) =>
    value is String ? value : fallback;
