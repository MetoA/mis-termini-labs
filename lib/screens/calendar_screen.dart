import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../blocs/terms_bloc/terms_bloc.dart';
import '../blocs/terms_bloc/terms_state.dart';
import '../models/terms.dart';
import '../widgets/term_list_tile.dart';

class CalendarScreen extends StatefulWidget {
  static String route = '/calendar';

  const CalendarScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<Term> _filteredTerms = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermsBloc, TermsState>(builder: (context, state) {
      _filteredTerms = state.terms.where((term) => term.sameDate(_focusedDay)).toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
        ),
        body: Center(
          child: Column(
            children: [
              TableCalendar(
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 1, 1),
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                eventLoader: (day) {
                  return state.terms
                      .where((term) => term.sameDate(day))
                      .toList();
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _selectedDay = focusedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) => events.isNotEmpty
                      ? Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.teal,
                          ),
                          child: Text(
                            '${events.length}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      : null,
                ),
                calendarStyle: const CalendarStyle(
                  markersAlignment: Alignment.bottomRight,
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return TermListTile(term: _filteredTerms[index], onDelete: () => {});
                },
                itemCount: _filteredTerms.length,
              ))
            ],
          ),
        ),
      );
    });
  }
}
