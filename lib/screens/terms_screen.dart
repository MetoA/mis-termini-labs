import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termini/blocs/terms_bloc/terms_bloc.dart';
import 'package:termini/blocs/terms_bloc/terms_state.dart';
import 'package:termini/models/terms.dart';
import 'package:termini/widgets/app_bar.dart';
import 'package:termini/widgets/create_term_modal.dart';
import 'package:termini/widgets/term_list_tile.dart';

import '../blocs/terms_bloc/terms_event.dart';

class TermsScreen extends StatelessWidget {
  static const String route = '/terms-list';

  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TermsAppBar(title: 'Terms', onAdd: () => _onAddElement(context)),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<TermsBloc, TermsState>(builder: (context, state) {
      if (state is TermsEmptyState || state is TermsInitialState) {
        return const Center(child: Text('There are currently no terms.'));
      } else if (state is TermsPopulatedState) {
        return Center(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return TermListTile(term: state.terms[index], onDelete: () => {});
            },
            itemCount: state.terms.length,
          ),
        );
      } else {
        return const Center(child: Text('We have encountered an unexpected error'));
      }
    });
  }

  void _onAddElement(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) {
      return GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.opaque,
        child: CreateTermModal(onCreate: _onCreateNewTerm,),
      );
    });
  }

  void _onCreateNewTerm(BuildContext context, Term term) {
    BlocProvider.of<TermsBloc>(context).add(TermAddedEvent(term: term));
    print(term);
  }
}
