import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/models/usermodel.dart';
import 'package:jo_ecom/services/providers/auth.dart';

class SignUpWidget extends ConsumerWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final zipController = TextEditingController();
    final areaController = TextEditingController();
    final countryController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Register',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const Text(
            'Fill out the form to gain access',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),
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
              fontSize: 12.0,
              height: 1.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(EvaIcons.emailOutline),
              prefixIconColor: Colors.black87,
              filled: true,
              fillColor: const Color.fromARGB(248, 235, 235, 235),
              label: const Text('Email (required)'),
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
              fontSize: 12.0,
              height: 1.0,
              color: Colors.black,
            ),
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(EvaIcons.lockOutline),
              prefixIconColor: Colors.black87,
              filled: true,
              fillColor: const Color.fromARGB(248, 235, 235, 235),
              label: const Text('Password (required)'),
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
          const SizedBox(height: 15),
          TextFormField(
            controller: nameController,
            style: const TextStyle(
              fontSize: 12.0,
              height: 1.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(EvaIcons.text),
              prefixIconColor: Colors.black87,
              filled: true,
              fillColor: const Color.fromARGB(248, 235, 235, 235),
              label: const Text('Name (eg. John Doe)'),
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
          const SizedBox(height: 15),
          TextFormField(
            controller: addressController,
            style: const TextStyle(
              fontSize: 12.0,
              height: 1.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(EvaIcons.homeOutline),
              prefixIconColor: Colors.black87,
              filled: true,
              fillColor: const Color.fromARGB(248, 235, 235, 235),
              label: const Text('Address'),
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
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * 0.4,
                child: TextFormField(
                  controller: zipController,
                  style: const TextStyle(
                    fontSize: 12.0,
                    height: 1.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(EvaIcons.hashOutline),
                    prefixIconColor: Colors.black87,
                    filled: true,
                    fillColor: const Color.fromARGB(248, 235, 235, 235),
                    label: const Text('ZIP'),
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
                      borderSide: const BorderSide(
                          width: 1, color: Colors.lightGreenAccent),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: areaController,
                  style: const TextStyle(
                    fontSize: 12.0,
                    height: 1.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(EvaIcons.mapOutline),
                    prefixIconColor: Colors.black87,
                    filled: true,
                    fillColor: const Color.fromARGB(248, 235, 235, 235),
                    label: const Text('Town'),
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
                      borderSide: const BorderSide(
                          width: 1, color: Colors.lightGreenAccent),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: countryController,
            style: const TextStyle(
              fontSize: 12.0,
              height: 1.0,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(EvaIcons.globe2Outline),
              prefixIconColor: Colors.black87,
              filled: true,
              fillColor: const Color.fromARGB(248, 235, 235, 235),
              label: const Text('Country'),
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
          const SizedBox(height: 10),
          MaterialButton(
            minWidth: width * 0.6,
            height: 45,
            color: Colors.greenAccent,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final user = UserModel(
                  id: 'id',
                  email: emailController.text,
                  createdAt: Timestamp.now(),
                  name: nameController.text,
                  address: addressController.text,
                  zip: zipController.text,
                  area: areaController.text,
                  country: countryController.text,
                );

                ref.read(authenticationProvider).signUpWithEmailAndPassword(
                    user, passwordController.text, context, ref);
              }
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
