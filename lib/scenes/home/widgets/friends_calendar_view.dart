import 'package:flutter/material.dart';
import 'package:inner_circle/common/app_colors.dart';
import 'package:rrule/rrule.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../data/models/friend_model.dart';

class FriendsCalendarView extends StatelessWidget {
  final List<Friend> friends;

  const FriendsCalendarView(this.friends, {super.key});

  @override
  Widget build(BuildContext context) {
    print("FriendsCalendarView");
    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventsDataSource(friends),
      // by default the month appointment display mode set as Indicator, we can
      // change the display mode as appointment using the appointment display
      // mode property
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment, showAgenda: true),
    );
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class EventsDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  EventsDataSource(List<Friend> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getEventData(index).birthday;
  }

  @override
  DateTime getEndTime(int index) {
    return _getEventData(index).birthday;
  }

  @override
  String getSubject(int index) {
    return _getEventData(index).name;
  }

  @override
  Color getColor(int index) {
    return AppColors.primary;
  }

  @override
  String getRecurrenceRule(int index) {
    var birthday = _getEventData(index).birthday;
    return
      RecurrenceRule(
      frequency: Frequency.yearly,
      byMonthDays: [birthday.day],
      byMonths: [birthday.month],
      interval: 1,
    ).toString();
  }

  @override
  bool isAllDay(int index) {
    return true;
  }

  Friend _getEventData(int index) {
    final dynamic meeting = appointments![index];
    late final Friend meetingData;
    if (meeting is Friend) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
