import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:jo_ecom/pages/authpage.dart';
import 'package:jo_ecom/pages/profilepage.dart';
import 'package:jo_ecom/services/providers/auth.dart';
import 'package:jo_ecom/services/providers/firebase.dart';
import 'package:jo_ecom/widgets/genericwidgets/iconwidget.dart';

class MenuWidget extends ConsumerWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    var userStream = ref.watch(userStreamProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: authState.when(
          data: (userSession) {
            if (userSession != null) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const IconWidget(icon: EvaIcons.menu2Outline),
                  userStream.when(
                    data: (user) {
                      if (user.isNotEmpty) {
                        return GestureDetector(
                          onTap: () => Get.to(const ProfilePage()),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(user.first.image ??
                                'https://firebasestorage.googleapis.com/v0/b/joecom-e54b3.appspot.com/o/generic%2Fno-user.jpg?alt=media&token=775706d1-b717-4bb5-9309-91b78d8f93a3'),
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                    error: (e, trace) {
                      Get.snackbar(
                        'Error',
                        e.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return const SizedBox();
                    },
                    loading: () => const CircularProgressIndicator(),
                  ),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const IconWidget(icon: EvaIcons.menu2Outline),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(12),
                    child: IconButton(
                      onPressed: () => Get.to(() => const AuthPage()),
                      icon: const Icon(EvaIcons.personOutline),
                    ),
                  ),
                ],
              );
            }
          },
          error: (e, trace) {
            Get.snackbar(
              'Error',
              e.toString(),
              snackPosition: SnackPosition.BOTTOM,
            );
            return const SizedBox();
          },
          loading: () => const CircularProgressIndicator()),
    );
  }
}
