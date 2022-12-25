import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:termini/blocs/terms_bloc/terms_bloc.dart';
import 'package:termini/blocs/terms_bloc/terms_state.dart';

class MapScreen extends StatefulWidget {
  static String route = '/map';

  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    getUserCurrentLocation().then((position) => {
          // _markers.add(Marker(
          //     markerId: MarkerId(LatLng(position.latitude, position.longitude).toString()),
          //     position: LatLng(position.latitude, position.longitude),
          //     icon: BitmapDescriptor.defaultMarker))
        });
    return BlocBuilder<TermsBloc, TermsState>(builder: (context, state) {
      _markers.addAll(state.terms
          .where((term) => term.location != null)
          .map((term) => Marker(
              markerId: MarkerId(term.location.toString()),
              position: term.location!,

              icon: BitmapDescriptor.defaultMarker))
          .toSet());

      return Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(target: LatLng(41.99646, 21.43141), zoom: 10),
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
          gestureRecognizers: Set()..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
          markers: _markers,
        ),
      );
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print('ERROR ${error.toString()}');
    });

    return await Geolocator.getCurrentPosition();
  }
}
