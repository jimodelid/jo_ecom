import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:jo_ecom/pages/authpage.dart';
import 'package:jo_ecom/root.dart';
import 'package:jo_ecom/services/classes/firebase.dart';
import 'package:jo_ecom/services/providers/firebase.dart';
import 'package:jo_ecom/services/providers/generic.dart';
import 'package:jo_ecom/widgets/portfoliowidgets/userphotowidget.dart';
import 'package:jo_ecom/widgets/portfoliowidgets/userwidget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userStream = ref.watch(userStreamProvider);

    return userStream.when(
        data: (data) {
          if (data.isNotEmpty) {
            final user = data.first;

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
                title: const Text('Profile'),
                actions: [
                  IconButton(
                    onPressed: () {
                      FirebaseAuthService()
                          .signOut(context, data)
                          .then((value) {
                        Get.snackbar(
                          'Success',
                          'You\'ve been signed out!',
                          snackPosition: SnackPosition.BOTTOM,
                        );

                        ref.read(pageProvider.notifier).setPage(0);
                      });
                      Get.offAll(() => const Root());
                    },
                    icon: const Icon(EvaIcons.logOutOutline),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                    right: 15,
                    left: 15,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      UserPhoto(user: user),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 30),
                      UserWidget(user: user),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const AuthPage();
          }
        },
        error: (e, trace) => SizedBox(child: Text(e.toString())),
        loading: () => const CircularProgressIndicator());
  }
}
