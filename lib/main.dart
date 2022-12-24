import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:termini/blocs/terms_bloc/terms_bloc.dart';
import 'package:termini/screens/login_screen.dart';
import 'package:termini/screens/terms_screen.dart';
import 'package:termini/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init();
  SharedPreferences.getInstance().then((prefs) {
    prefs.clear();
    bool isLoggedIn = prefs.getString('logged_username') != null;
    runApp(MyApp(isLoggedIn: isLoggedIn));
  });
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TermsBloc(),
        child: MaterialApp(
            title: 'Terms',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(secondary: Colors.tealAccent),
            ),
            initialRoute: isLoggedIn ? TermsScreen.route : LoginScreen.route,
            routes: {
              LoginScreen.route: (context) => const LoginScreen(),
              TermsScreen.route: (context) => TermsScreen()
            }));
  }
}
