//@dart=2.9
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:firebasetest/map screens/firescreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/screens/user/homescreen.dart';
import 'package:firebasetest/screens/user/mainscreen.dart';
import 'package:firebasetest/screens/user/splashscreen.dart';
import 'package:firebasetest/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key1',
      channelName: 'AlertUs',
      channelDescription: 'Confirmation of Report',
      defaultColor: Colors.red,
      ledColor: Colors.red,
      vibrationPattern: highVibrationPattern,
      channelShowBadge: true,
      playSound: true,
      enableLights: true,
      enableVibration: true,
      importance: NotificationImportance.High,
    )
  ]);
  runApp(ThisApp());
}

class ThisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "APP",
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    if (user != null) {
      return SplashScreen();
    }
    if (user == null) {
      return MainScreen();
    }
  }
}
