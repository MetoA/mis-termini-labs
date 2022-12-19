import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termini/blocs/terms_bloc/terms_event.dart';
import 'package:termini/blocs/terms_bloc/terms_state.dart';

import '../../models/terms.dart';

class TermsBloc extends Bloc<TermsEvent, TermsState> {
  List<Term> _terms = [];

  TermsBloc() : super(TermsInitialState()) {
    on<TermsInitializedEvent>((event, emit) {
      _terms = [];
      var state = TermsEmptyState();
      state.terms = _terms;
      emit(state);
    });

    on<TermAddedEvent>((event, emit) {
      _terms.add(event.term);
      emit(TermsPopulatedState(terms: _terms));
    });

    on<TermDeletedEvent>((event, emit) {
      _terms.removeWhere((term) => term.id == event.id);

      if (_terms.isNotEmpty) {
        emit(TermsPopulatedState(terms: _terms));
      } else {
        emit(TermsEmptyState());
      }
    });
  }
}