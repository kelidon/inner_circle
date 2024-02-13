import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:inner_circle/common/app_colors.dart';
import 'package:rrule/rrule.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../common/app_routes.dart';
import '../../../data/models/friend_model.dart';

class FriendsCalendarView extends StatelessWidget {
  final List<Friend> friends;

  const FriendsCalendarView(this.friends, {super.key});

  @override
  Widget build(BuildContext context) {
    print("FriendsCalendarView");
    return SfCalendar(
      view: CalendarView.month,
      firstDayOfWeek: 1,
      dataSource: EventsDataSource(friends),
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator, showAgenda: true),
      appointmentBuilder: appointmentBuilder,
    );
  }

  Widget appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails calendarAppointmentDetails) {
    final Appointment appointment = calendarAppointmentDetails.appointments.first;
    final friend = friends.firstWhere((element) => element.id == appointment.subject);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.updateFriend, arguments: friend),
      child: GlowContainer(
        glowColor: AppColors.schemeSeed.withOpacity(0.5),
        blurRadius: 2,
        borderRadius: BorderRadius.all(Radius.circular(1)),
        padding: EdgeInsets.all(4),
        color: appointment.color,
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(text: friend.name, style: TextStyle(fontSize: 12), children: [
            TextSpan(
                text: "  ${appointment.startTime.year - friend.birthday.year}",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 10,
                    fontWeight: FontWeight.bold))
          ]),
        ),
      ),
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
    return _getEventData(index).id;
  }

  @override
  Color getColor(int index) {
    return AppColors.primary;
  }

  @override
  String getRecurrenceRule(int index) {
    var birthday = _getEventData(index).birthday;
    return RecurrenceRule(
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
