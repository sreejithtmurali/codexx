import 'package:codex/providers/auth_provider.dart';
import 'package:codex/providers/dashboard_provider.dart';
import 'package:codex/services/apiservice.dart';
import 'package:codex/services/user_service.dart';
import 'package:codex/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final userService = UserService(prefs);

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: userService),
        ProxyProvider<UserService, Apiservice>(
          update: (context, userService, previous) =>
              previous ?? Apiservice(userService),
        ),
        ChangeNotifierProxyProvider<Apiservice, DashboardProvider>(
          create: (context) => DashboardProvider(context.read<Apiservice>()),
          update: (context, apiService, dashboardProvider) =>
              dashboardProvider ?? DashboardProvider(apiService),
        ),
        ChangeNotifierProxyProvider2<Apiservice, UserService, AuthProvider>(
          create: (context) => AuthProvider(
            context.read<Apiservice>(),
            context.read<UserService>(),
          ),
          update: (context, apiService, userService, authProvider) =>
              authProvider ?? AuthProvider(apiService, userService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'codex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}
