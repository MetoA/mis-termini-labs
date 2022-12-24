import '../../models/terms.dart';

abstract class TermsEvent {}

class TermsInitializedEvent extends TermsEvent {}

class TermAddedEvent extends TermsEvent {
  final Term term;

  TermAddedEvent({required this.term});
}

class TermDeletedEvent extends TermsEvent {
  final String id;

  TermDeletedEvent({required this.id});
}
