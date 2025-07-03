import 'package:baby_care/core/services/local_storage_service.dart';
import 'package:baby_care/core/utils/app_color.dart';
import 'package:baby_care/core/widgets/custom_button.dart';
import 'package:baby_care/core/widgets/custom_calendar.dart';
import 'package:baby_care/core/widgets/page_layout_widget.dart';
import 'package:baby_care/screens/date_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  String title = "";
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final TextEditingController _dateField = TextEditingController()
    ..text = DateFormat('yyyy-MM-dd').format(DateTime.now());

  void _inputFieldChange(String value) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    DateTime date = formatter.parse(value);
    setState(() {
      _selectedDate = date;
    });
  }

  Future<void> _saveSelectedDate() async {
    LocalStorageService.instance.saveSelectedDate(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageLayoutWidget(
          bottomChild: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(color: Colors.white),
            child: CustomButton(
              text: "Next",
              onPressed: () {
                _saveSelectedDate();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DateConfirmationPage(title: title, date: _selectedDate),
                  ),
                );
              },
            ),
          ),
          children: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 16,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: AppColors.primaryColor.withAlpha(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Text(
                        "Enter the first day of your last period to calculate your due date",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),

                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Why are we asking and how we calculate it?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                          color: AppColors.textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: _dateField,
                  onChanged: (value) {
                    _inputFieldChange(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter date ( Example:  2023-10-18)',
                    labelStyle: TextStyle(color: Colors.red),
                    hintStyle: TextStyle(color: AppColors.grayTextColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.borderGray),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.borderGray,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: List.filled(
                      1,
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 19,
                        spreadRadius: 0,
                        offset: Offset(2, 16),
                      ),
                    ),
                  ),
                  child: CustomCalendar(
                    onDateSelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                      });
                      _dateField.text = DateFormat(
                        'yyyy-MM-dd',
                      ).format(selectedDay);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
