import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_example/screens/auth/theme_store.dart';
import 'package:mobx_example/screens/home/home_screen.dart';
import 'package:mobx_example/widgets/logo.dart';
import 'package:provider/provider.dart';

import '../../widgets/blob_painter.dart';
import 'auth_store.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthStore authStore;
  late ThemeStore themeStore;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _userNameController;

  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
  }

  @override
  void dispose() {
    reactionDisposer();

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    authStore = Provider.of<AuthStore>(context);
    themeStore = Provider.of<ThemeStore>(context);

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
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: ListView(
          children: [
            Stack(
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 200),
                  painter: BlotPainter(Theme.of(context).colorScheme.secondary),
                ),
                const Positioned(
                    left: 24,
                    top: 24,
                    child: SizedBox.square(dimension: 50, child: Logo())),
              ],
            ),
            SizedBox(
              height: 250,
              child: TabBarView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 40),
                      Switch(
                          value: themeStore.isDark,
                          onChanged: (_) => themeStore.changeTheme()),
                      Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            enabled: !authStore.loading,
                            onChanged: authStore.setEmail,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            onSubmitted: (_) => authStore.login(),
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                              enabled: !authStore.loading,
                              onChanged: authStore.setPassword,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              onSubmitted: (_) => authStore.login(),
                              scrollPadding: EdgeInsets.only(bottom: 20),
                              decoration: const InputDecoration(
                                  label: Text('Password')),
                              controller: _passwordController),
                        );
                      })
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            enabled: !authStore.loading,
                            onChanged: authStore.setEmail,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            onSubmitted: (_) => authStore.signUp(),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                              enabled: !authStore.loading,
                              onChanged: authStore.setPassword,
                              onSubmitted: (_) => authStore.signUp(),
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  label: Text('Username')),
                              controller: _userNameController),
                        );
                      }),
                      const SizedBox(height: 20),
                      Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                              enabled: !authStore.loading,
                              onChanged: authStore.setPassword,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              onSubmitted: (_) => authStore.signUp(),
                              decoration: const InputDecoration(
                                  label: Text('Password')),
                              controller: _passwordController),
                        );
                      }),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.secondary,
                  child: TabBar(
                    splashBorderRadius: BorderRadius.circular(100),
                    indicator: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Text('Login'),
                      Tab(text: 'Sign-up'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 42),
            TextButton(onPressed: () {}, child: const Text('Forgot password?')),
          ],
        ),
      ),
    );
  }
}
