import 'package:equatable/equatable.dart';

class Term extends Equatable {
  final String id;
  final String name;
  final DateTime dateTime;

  const Term({required this.id, required this.name, required this.dateTime});

  @override
  List<Object?> get props => [id];

  bool sameDate(DateTime other) {
    return dateTime.year == other.year &&
        dateTime.month == other.month &&
        dateTime.day == other.day;
  }

  Term.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        dateTime = DateTime.parse(json['dateTime']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'dateTime': dateTime.toString()};
}
