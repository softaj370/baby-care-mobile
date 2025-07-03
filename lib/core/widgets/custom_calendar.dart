import 'package:baby_care/core/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  final void Function(DateTime, DateTime) onDateSelected;

  const CustomCalendar({super.key, required this.onDateSelected});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.now(),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
          _focusedDay = focusedDay;
        });
        widget.onDateSelected(_selectedDate, _focusedDay);
      },
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          return Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primaryColor,
              ),
              child: Text(
                DateFormat.yMMM().format(day),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        headerPadding: EdgeInsets.symmetric(vertical: 8),
      ),
      
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.secondaryColor,
        ),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
