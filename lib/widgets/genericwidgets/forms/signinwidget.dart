import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/main.dart';
import 'package:jo_ecom/pages/homepage.dart';
import 'package:jo_ecom/services/providers/auth.dart';
import 'package:jo_ecom/services/providers/generic.dart';
import 'package:jo_ecom/widgets/genericwidgets/spacerwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/toastwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';

class SignInWidget extends ConsumerWidget {
  const SignInWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Form(
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
              contentPadding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
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
                borderSide:
                    const BorderSide(width: 1, color: Colors.lightGreenAccent),
              ),
            ),
          ),
          const VerticalSpacerWidget(height: 15),
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
              contentPadding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
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
                borderSide:
                    const BorderSide(width: 1, color: Colors.lightGreenAccent),
              ),
            ),
          ),
          const VerticalSpacerWidget(height: 10),
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
                      context,
                    )
                    .then((value) {
                  toast(context, 'You\'ve been signed in.');
                  ref.read(pageProvider.notifier).setPage(0);
                });
              }
            },
            child: const Text('Sign in'),
          ),
        ],
      ),
    );
  }
}
