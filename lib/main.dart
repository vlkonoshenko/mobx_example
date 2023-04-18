import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_example/screens/auth/auth_store.dart';
import 'package:mobx_example/screens/auth/theme_store.dart';
import 'package:mobx_example/screens/home/home_screen.dart';
import 'package:mobx_example/screens/splash/splash.dart';
import 'package:mobx_example/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeStore = ThemeStore();
  final authStore = AuthStore();

  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => authStore),
        Provider(create: (_) => themeStore),
      ],
      child: Provider<AuthStore>(
        create: (_) => AuthStore(),
        child: Observer(builder: (_) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: AppTheme.theme(themeStore.isDark),
            home: Splash(),
          );
        }),
      ),
    );
  }
}
