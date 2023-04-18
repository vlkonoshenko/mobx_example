import 'package:flutter/material.dart';
import 'package:mobx_example/screens/auth/auth_screen.dart';
import 'package:mobx_example/screens/auth/auth_store.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
            onPressed: () {
              context.read<AuthStore>().loggout();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const AuthScreen()));
            },
            child: Text('Logout')),
      ),
    );
  }
}
