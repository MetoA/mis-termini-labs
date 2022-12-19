import 'package:equatable/equatable.dart';

class Term extends Equatable{
  final String id;
  final String name;
  final DateTime dateTime;

  const Term({required this.id, required this.name, required this.dateTime});

  @override
  List<Object?> get props => [id];
}
