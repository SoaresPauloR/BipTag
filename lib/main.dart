import 'package:biptag/screens/inventory.dart';
import 'package:biptag/screens/inventory_form.dart';
import 'package:biptag/screens/login.dart';
import 'package:biptag/screens/user_registration.dart';
import 'package:biptag/screens/welcome.dart';
import 'package:biptag/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:biptag/screens/perfil.dart';
import 'package:biptag/screens/credits.dart';
import 'package:biptag/providers/inventory_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => InventoryProvider(),
      child: MaterialApp(
        title: "BipTag",
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomeScreen(),
          '/login': (context) => const Login(),
          '/register': (context) => const UserRegistration(),
          '/inventory': (context) => const Inventory(),
          '/inventory/create': (context) => const InventoryForm(),
          '/perfil': (context) => const Perfil(),
          '/creditos': (context) => const Credits(),
        },
      ),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/inventory');
          },
          child: const Text("Go to Inventory"),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("BipTag");
  }
}
