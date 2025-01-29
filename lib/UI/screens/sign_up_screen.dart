
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../auth/auth_bloc/auth_cubit.dart';
import '../../utils/colors.dart';
import '../../utils/colors.dart';
import '../../utils/single_ton.dart';
import '../widgets/Custom_Text_loginSignup.dart';
import '../widgets/custom_btn.dart';
import '../widgets/custom_google_btn.dart';
import '../widgets/custom_textfield_email_password.dart';
import '../widgets/line_or_text.dart';
import 'home_screen.dart';
import 'log_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  /// Regular Expression for Email Validation
  final RegExp emailRegex =
  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  /// Validate Email Format
  bool isValidEmail(String email) {
    return emailRegex.hasMatch(email);
  }

  void register() {
    final String email = emailController.text.toString().trim();
    final String password = passwordController.text.trim();
    final String name = nameController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    final authCubit = getIt<AuthCubit>();

    if (email.isEmpty || password.isEmpty || name.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
        ),
      );
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email format"),
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return;
    }

    /// Proceed to Signup
    authCubit.signup(name, email, password);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Verified) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.greyShade300,

        /// App Bar
        appBar: AppBar(
          backgroundColor: CustomColors.greyShade300,
          title: Text(
            'BLOC Sign Up Screen',
            style: TextStyle(
                color: CustomColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.login,
                size: 30,
                color: CustomColors.grey,
              ),
            )
          ],
        ),

        /// Main Body
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Lottie.asset('assets/Fire.json'),
                ),
                const SizedBox(height: 50),
                Custom_Container(
                  hintText: 'Name',
                  controller: nameController,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                Custom_Container(
                  controller: confirmPasswordController,
                  hintText: 'Enter a confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 40),

                /// Register Button
                Custom_Btn_Login_signUp(
                  ontap: register,
                  text: 'Sign Up',
                ),
                const SizedBox(height: 20),
                Custom_Text_loginSignup(
                  details: 'Have an account?',
                  text: 'Log In',
                  ontap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Line_Or_Widget(),
                const SizedBox(
                  height: 10,
                ),
                GoogleBtn(
                  text: 'Sign In with Google',
                  ontap: () {
                    // TODO: Implement Google Sign In
                    final authCubit = getIt<AuthCubit>();
                    authCubit
                        .signInWithGoogleProcess();
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
