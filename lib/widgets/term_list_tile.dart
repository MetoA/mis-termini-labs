import 'package:flutter/material.dart';
import 'package:termini/extensions/date_extensions.dart';

import '../models/terms.dart';

class TermListTile extends StatelessWidget {
  final Term term;
  final Function onDelete;

  const TermListTile({super.key, required this.term, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      child: ListTile(
        title: Text(
          term.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(term.dateTime.dateString()),
        trailing: term.location == null ? null : IconButton(
          icon: const Icon(Icons.pin_drop_rounded),
          onPressed: () => {},
        ),
      ),
    );
  }
}
