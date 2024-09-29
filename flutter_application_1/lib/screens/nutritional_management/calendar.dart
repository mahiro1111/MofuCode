import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  // 日付と条件を満たすイベントの定義（例: イベントの日に星マークを付ける）
  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2024, 9, 2): ['イベント1'],
    DateTime.utc(2024, 9, 5): ['イベント2'],
    DateTime.utc(2024, 9, 15): ['イベント3'],
    DateTime.utc(2024, 9, 28): ['イベント4'],
  };

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      eventLoader: (day) {
        // 条件を満たすイベントをロード
        return _events[day] ?? [];
      },
      calendarBuilders: CalendarBuilders(
        // 条件を満たす日付に星マークを表示
        markerBuilder: (context, day, events) {
          if (events.isNotEmpty) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
              size: 50.0,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
