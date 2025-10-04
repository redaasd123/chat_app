import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/cubit/chat_cubit.dart';
import 'package:chat_app/pages/cubit/register_cubit.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widget/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widget/custom_button.dart';
import '../widget/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'registerPage';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? password;
  String? email;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          BlocProvider.of<ChatCubit>(context).getMessages();
          isLoading = false;
        } else if (state is RegisterFailure) {
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
                key: globalKey,
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
                          if (globalKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context).registerUser(
                              email: email!,
                              password: password!,
                            );
                          }
                        },
                        child: const Text(
                          'REGISTER',
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
                          "already have an account?",
                          style: TextStyle(color: Colors.black87, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, LoginPage.id),
                          child: const Text(
                            'login',
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

