import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  String get formattedDate => DateFormat('dd/MM/yyyy').format(this);
  String get formattedTime => DateFormat('hh:mm a').format(this);
  String get dayString => DateFormat('dd').format(this);
  String get weekString => DateFormat('EEE').format(this);
  String get shortDayString => DateFormat('dd EEE • hh:mm a').format(this);

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  int get daysDifference => daysElapsedSince(
        DateTime.now(),
        this,
      );

  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  ///
  /// True if this date is on a leap year.
  ///
  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  int get weekOfYear {
    final woy = (ordinalDate - weekday + 10) ~/ 7;
    if (woy == 0) {
      return DateTime(year - 1, 12, 28).weekOfYear;
    }
    if (woy == 53 &&
        DateTime(year).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }
    return woy;
  }

  String formatted() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (isAfter(today)) {
      return DateFormat('h:mm aa').format(this);
    } else if (isAfter(yesterday)) {
      return 'Yesterday';
    } else {
      const dateFormat = 'dd/MM/yy';
      return DateFormat(dateFormat).format(this);
    }
  }

  bool isAfterBeforeTime(DateTimeRange range) {
    return (isAfter(range.start) || isAtSameMomentAs(range.start)) &&
        (isAtSameMomentAs(range.end) || isBefore(range.end));
  }
}

int daysElapsedSince(DateTime from, DateTime to) {
  final newFrom = DateTime(from.year, from.month, from.day);
  final newTo = DateTime(to.year, to.month, to.day);
  return newTo.difference(newFrom).inDays;
}
