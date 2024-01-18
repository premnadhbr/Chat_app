import 'package:chat_app/app/controller/auth/bloc/auth_bloc.dart';
import 'package:chat_app/app/controller/home/bloc/home_bloc.dart';
import 'package:chat_app/app/utils/constants/app_theme.dart';
import 'package:chat_app/app/view/onboard/onboard.dart';
import 'package:chat_app/app/view/profile/profile.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardScreen(),
      theme: lightMode,
    );
  }
}