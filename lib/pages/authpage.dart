import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/providers/auth.dart';
import 'package:jo_ecom/services/providers/generic.dart';
import 'package:jo_ecom/widgets/genericwidgets/signupwidget.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: const Text('Sign in'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
              width: width * 0.8,
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: emailController,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]')),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email must not be empty";
                            }
                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Email is incorrectly formatted";
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontSize: 14.0,
                            height: 1.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(EvaIcons.emailOutline),
                            prefixIconColor: Colors.black87,
                            filled: true,
                            fillColor: const Color.fromARGB(248, 235, 235, 235),
                            label: const Text('Email'),
                            labelStyle: const TextStyle(color: Colors.black),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 6, 10, 6),
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 2,
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(248, 228, 228, 228),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.lightGreenAccent),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password must not be empty";
                            }

                            if (value.length < 8) {
                              return "Password must be atleast 8 characters long";
                            }

                            return null;
                          },
                          style: const TextStyle(
                            fontSize: 14.0,
                            height: 1.0,
                            color: Colors.black,
                          ),
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(EvaIcons.lockOutline),
                            prefixIconColor: Colors.black87,
                            filled: true,
                            fillColor: const Color.fromARGB(248, 235, 235, 235),
                            label: const Text('Password'),
                            labelStyle: const TextStyle(color: Colors.black),
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 6, 10, 6),
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 2,
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(248, 228, 228, 228),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.lightGreenAccent),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        MaterialButton(
                          minWidth: width * 0.6,
                          height: 45,
                          color: Colors.greenAccent,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ref
                                  .read(authenticationProvider)
                                  .signInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text,
                                  )
                                  .then((_) {
                                ref.read(pageProvider.notifier).setPage(0);
                              });
                            }
                          },
                          child: const Text('Sign in'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Not a member yet?\nPress the button below to get started.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    minWidth: width * 0.6,
                    height: 45,
                    color: Colors.amberAccent,
                    onPressed: () {
                      _showSimpleModalDialog(context, height * 0.85);
                    },
                    child: const Text('Register'),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

_showSimpleModalDialog(context, height) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          constraints: BoxConstraints(maxHeight: height),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: SignUpWidget(),
          ),
        ),
      );
    },
  );
}
