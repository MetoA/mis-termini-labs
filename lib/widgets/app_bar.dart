import 'package:flutter/material.dart';
import 'package:termini/screens/calendar_screen.dart';

class TermsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onAdd;
  final Function onLogOut;

  const TermsAppBar({super.key, required this.title, required this.onAdd, required this.onLogOut});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(onPressed: () => onLogOut(), icon: const Icon(Icons.logout)),
        IconButton(onPressed: () => _goToCalendarView(context), icon: const Icon(Icons.calendar_month)),
        IconButton(onPressed: () => onAdd(), icon: const Icon(Icons.add))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _goToCalendarView(BuildContext context) {
    Navigator.of(context).pushNamed(CalendarScreen.route);
  }
}
