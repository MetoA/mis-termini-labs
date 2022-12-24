import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:termini/blocs/terms_bloc/terms_event.dart';
import 'package:termini/blocs/terms_bloc/terms_state.dart';

import '../../models/terms.dart';

class TermsBloc extends Bloc<TermsEvent, TermsState> {
  List<Term> _terms = [];

  TermsBloc() : super(TermsInitialState()) {
    on<TermsInitializedEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String termsKey = '${prefs.getString('logged_username')}_terms';

      if (prefs.containsKey(termsKey)) {
        _terms = prefs.getStringList(termsKey)!.map((it) => Term.fromJson(jsonDecode(it))).toList();
      } else {
        prefs.setStringList(termsKey, []);
        _terms = [];
      }

      var state = _terms.isEmpty ? TermsEmptyState() : TermsPopulatedState(terms: _terms);
      state.terms = _terms;
      emit(state);
    });

    on<TermAddedEvent>((event, emit) async {
      _terms.add(event.term);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('${prefs.getString('logged_username')!}_terms', _terms.map((it) => jsonEncode(it)).toList());
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
