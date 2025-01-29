
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/UI/screens/sign_up_screen.dart';

import '../../auth/auth_bloc/auth_cubit.dart';
import '../../utils/colors.dart';

import '../../utils/single_ton.dart';
import '../widgets/Custom_Text_loginSignup.dart';
import '../widgets/custom_btn.dart';
import '../widgets/custom_google_btn.dart';
import '../widgets/custom_textfield_email_password.dart';
import '../widgets/line_or_text.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    final String email = emailController.text;
    final String password = passwordController.text;

    /// Auth Cubit

    final authCubit = getIt<AuthCubit>();
    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Enter the Email and Password"),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return

        BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Verified) {
          // Navigate to the home screen when the user is verified
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const HomeScreen()), // Replace HomeScreen with your actual home screen
          );
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.error)), // Display error message if any
          );
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.greyShade300,
        appBar: AppBar(
          backgroundColor: CustomColors.greyShade300,
          title: Text(
            'BLOC Login Screen',
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.login,
                size: 30,
                color: CustomColors.grey,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Lottie.asset('assets/Fire.json'),
                ),
                const SizedBox(height: 50),
                Custom_Container(
                  controller: emailController,
                  hintText: 'Enter an Email',
                ),
                const SizedBox(height: 20),
                Custom_Container(
                  controller: passwordController,
                  hintText: 'Enter a Password',
                  obscureText: true,
                ),
                const SizedBox(height: 50),
                Custom_Btn_Login_signUp(
                  ontap: login,
                  text: 'Login',
                ),
                const SizedBox(height: 20),
                Custom_Text_loginSignup(
                  details: 'Don\'t have an account?',
                  text: 'Sign Up',
                  ontap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Line_Or_Widget(),
                const SizedBox(height: 10),
                GoogleBtn(
                  text: 'Sign In with Google',
                  ontap: () {
                    final authCubit = getIt<AuthCubit>();
                    authCubit
                        .signInWithGoogleProcess(); // Trigger the Google Sign-In process
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
