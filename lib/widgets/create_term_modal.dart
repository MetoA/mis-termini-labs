import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  final Set<Marker> _markers = {};
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
          Container(
            height: 200,
            width: 350,
            margin: const EdgeInsets.only(top: 20),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(target: LatLng(41.99646, 21.43141), zoom: 10),
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              gestureRecognizers: Set()..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
              markers: _markers,
              onTap: (latlng) {
                setState(() {
                  _markers.clear();
                  _markers.add(Marker(
                      markerId: MarkerId(latlng.toString()), position: latlng, icon: BitmapDescriptor.defaultMarker));
                });
              },
            ),
          ),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: ElevatedButton(
              onPressed: _nameController.text.isEmpty || _dateTime == null
                  ? null
                  : () {
                      var term = Term(id: nanoid(5), name: _nameController.text, dateTime: _dateTime!, location: _markers.isEmpty ? null : _markers.first.position);
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
