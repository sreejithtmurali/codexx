import 'package:codex/providers/auth_provider.dart';
import 'package:codex/services/apiservice.dart';
import 'package:codex/views/loginview.dart';
import 'package:codex/views/onboarding.dart';
import 'package:codex/views/otpverify.dart';
import 'package:codex/views/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => Apiservice()),
        ChangeNotifierProxyProvider<Apiservice, AuthProvider>(
          create: (context) => AuthProvider(context.read<Apiservice>()),
          update: (context, apiService, authProvider) =>
              authProvider ?? AuthProvider(apiService),
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
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: OnboardingScreen(),
    );
  }
}
