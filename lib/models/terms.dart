import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Term extends Equatable {
  final String id;
  final String name;
  final DateTime dateTime;
  final LatLng? location;

  const Term({required this.id, required this.name, required this.dateTime, this.location});

  @override
  List<Object?> get props => [id];

  bool sameDate(DateTime other) {
    return dateTime.year == other.year && dateTime.month == other.month && dateTime.day == other.day;
  }

  Term.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        dateTime = DateTime.parse(json['dateTime']),
        location = json['lat'] != null ? LatLng(json['lat'], json['lng']) : null;

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'dateTime': dateTime.toString(), 'lat': location?.latitude, 'lng': location?.longitude};
}
