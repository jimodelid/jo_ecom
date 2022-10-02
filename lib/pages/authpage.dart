// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/widgets/genericwidgets/spacerwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/forms/signinwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/forms/signupwidget.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                  const SignInWidget(),
                  const VerticalSpacerWidget(height: 50),
                  const Text(
                    'Not a member yet?\nPress the button below to get started.',
                    textAlign: TextAlign.center,
                  ),
                  const VerticalSpacerWidget(height: 10),
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
