import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:termini/screens/terms_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _usernameController = TextEditingController();
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  onChanged: (text) {
                    setState(() {
                      username = text;
                    });
                  },
                  decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your existing username or a new one...'
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                  onPressed: username.isEmpty
                      ? null
                      : () {
                          _prefs.then((prefs) => prefs.setString('logged_username', username));
                          Navigator.of(context).pushNamedAndRemoveUntil(TermsScreen.route, (route) => false);
                        },
                  child: const Text('Login'),
                )
                )
              ],
            ),
          ),
        ));
  }
}
