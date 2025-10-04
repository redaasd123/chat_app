import 'package:chat_app/pages/cubit/chat_cubit.dart';
import 'package:chat_app/pages/cubit/login_cubit.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool isLoading = false;
  final GlobalKey<FormState> globalKeyLogin = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Form(
                key: globalKeyLogin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'ChatVerse 💬',
                      style: TextStyle(
                        fontSize: 38,
                        color: Color(0xFF0A4D68),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome back! Please login to continue.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),

                    // Email field
                    CustomTextField(
                      onChanged: (data) => email = data,
                      hintText: 'Email Address',
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 20),

                    // Password field
                    CustomTextField(
                      obscureText: true,
                      onChanged: (data) => password = data,
                      hintText: 'Password',
                      icon: Icons.lock_outline,
                    ),
                    const SizedBox(height: 30),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A4D68),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          if (globalKeyLogin.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context).loginUser(
                              email: email!,
                              password: password!,
                            );
                          }
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Divider line
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 0.6,
                              indent: 30,
                              endIndent: 10,
                            )),
                        const Text("or",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        const Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 0.6,
                              indent: 10,
                              endIndent: 30,
                            )),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Register text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, RegisterPage.id),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Color(0xFF0A4D68),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
