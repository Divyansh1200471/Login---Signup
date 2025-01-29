import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/utils/single_ton.dart';

import 'UI/screens/home_screen.dart';
import 'UI/screens/log_in_screen.dart';
import 'auth/auth_bloc/auth_cubit.dart';
import 'auth/auth_repo/auth_repo.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('authBox');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final authRepo = AuthRepo();
  final bool isLoggedIn;

  MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);
            if (authState is Unverified || !isLoggedIn) {
              return const LoginScreen();
            }
            if (authState is Verified && isLoggedIn) {
              return const HomeScreen();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
