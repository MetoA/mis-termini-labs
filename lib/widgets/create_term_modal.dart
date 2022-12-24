import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:nanoid/nanoid.dart';
import 'package:termini/extensions/date_extensions.dart';
import 'package:termini/models/terms.dart';

class CreateTermModal extends StatefulWidget {
  final Function onCreate;

  const CreateTermModal({super.key, required this.onCreate});

  @override
  State<StatefulWidget> createState() => _CreateTermModalState();
}

class _CreateTermModalState extends State<CreateTermModal> {
  final _nameController = TextEditingController();
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    onConfirm: _onDateSelect,
                    currentTime: _dateTime ?? DateTime.now(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.access_time),
                  Container(padding: const EdgeInsets.only(left: 10), child: Text(_dateRepresentation()))
                ]),
              )),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: ElevatedButton(
              onPressed: _nameController.text.isEmpty || _dateTime == null
                  ? null
                  : () {
                      var term = Term(id: nanoid(5), name: _nameController.text, dateTime: _dateTime!);
                      widget.onCreate(context, term);
                      Navigator.of(context).pop();
                    },
              style: ElevatedButton.styleFrom(elevation: 3, textStyle: const TextStyle(fontSize: 20)),
              child: const Text('Create'),
            ),
          ))
        ],
      ),
    );
  }

  void _onDateSelect(DateTime dateTime) {
    setState(() {
      _dateTime = dateTime;
    });
  }

  String _dateRepresentation() {
    if (_dateTime == null) {
      return 'Select date and time';
    } else {
      return _dateTime!.dateString();
    }
  }
}
