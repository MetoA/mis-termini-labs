import '../../models/terms.dart';

abstract class TermsState {
  List<Term> terms;

  TermsState({required this.terms});
}

class TermsInitialState extends TermsState {
  TermsInitialState() : super(terms: []);
}

class TermsEmptyState extends TermsState {
  TermsEmptyState() : super(terms: []);
}

class TermsPopulatedState extends TermsState {
  TermsPopulatedState({terms}) : super(terms: terms);
}

class TermsErrorState extends TermsState {
  final String error;
  TermsErrorState({required this.error}) : super(terms: []);
}
