import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_example/screens/auth/auth_screen.dart';
import 'package:mobx_example/screens/auth/auth_store.dart';
import 'package:mobx_example/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late ReactionDisposer reactionDisposer;
  late final AuthStore authStore;

  @override
  void initState() {
    super.initState();

    authStore = context.read<AuthStore>();

    if (authStore.isLoggedIn != null) {
      if (authStore.isLoggedIn ?? false) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AuthScreen()));
      }
    } else {
      authStore.checkLogin();
    }
  }

  @override
  void dispose() {
    reactionDisposer();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    reactionDisposer = reaction((_) => authStore.isLoggedIn, (bool? loggedIn) {
      if (loggedIn ?? false) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AuthScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
