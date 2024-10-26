import 'package:FatCat/constants/colors.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class StudyStreakWidget extends StatelessWidget {
  final int streak;
  final DateTime streakStartAt;

  const StudyStreakWidget({
    super.key,
    required this.streak,
    required this.streakStartAt,
  });

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: Colors.white,
            foregroundColor: AppColors.blackText,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Chuỗi $streak ngày',
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Icon(Icons.local_fire_department,
                    size: 72, color: Colors.orange),
                const SizedBox(height: 8),
                const Text('Hãy học vào ngày mai\nđể duy trì chuỗi của bạn!',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 16),
                _buildCalendar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    final now = _normalizeDate(DateTime.now());
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final normalizedStreakStartAt = _normalizeDate(streakStartAt);
    final streakEndDate =
        normalizedStreakStartAt.add(Duration(days: streak - 1));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        final date = startOfWeek.add(Duration(days: index));
        return _calendarDay(date, normalizedStreakStartAt, streakEndDate, now);
      }),
    );
  }

  Widget _calendarDay(DateTime date, DateTime normalizedStreakStartAt,
      DateTime streakEndDate, DateTime today) {
    final isInStreak =
        !date.isBefore(normalizedStreakStartAt) && !date.isAfter(streakEndDate);
    final isToday = date.isAtSameMomentAs(today);

    final dayName = _getDayName(date.weekday);

    return Container(
      width: 40,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isInStreak ? Colors.orange.withOpacity(0.6) : Colors.transparent,
        border: isToday ? Border.all(color: AppColors.green, width: 2) : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        date.day.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'T2';
      case DateTime.tuesday:
        return 'T3';
      case DateTime.wednesday:
        return 'T4';
      case DateTime.thursday:
        return 'T5';
      case DateTime.friday:
        return 'T6';
      case DateTime.saturday:
        return 'T7';
      case DateTime.sunday:
        return 'CN';
      default:
        return '';
    }
  }
}
