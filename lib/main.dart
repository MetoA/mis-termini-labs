import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:termini/blocs/terms_bloc/terms_bloc.dart';
import 'package:termini/screens/terms_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TermsBloc(),
        child: MaterialApp(
            title: 'Terms',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
                  .copyWith(secondary: Colors.tealAccent),
            ),
            initialRoute: '/terms-list',
            routes: {TermsScreen.route: (context) => const TermsScreen()}));
  }
}
