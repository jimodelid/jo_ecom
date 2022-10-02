import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/pages/AuthPage.dart';
import 'package:jo_ecom/pages/profilepage.dart';
import 'package:jo_ecom/services/providers/auth.dart';
import 'package:jo_ecom/services/providers/firebase.dart';
import 'package:jo_ecom/services/providers/generic.dart';
import 'package:jo_ecom/widgets/genericwidgets/iconwidget.dart';
import 'package:page_transition/page_transition.dart';

class MenuWidget extends ConsumerWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    var userStream = ref.watch(userStreamProvider);

    return authState.when(
        data: (userSession) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const IconWidget(icon: EvaIcons.menu2Outline),
              GestureDetector(
                onTap: () {
                  if (userSession != null) {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const ProfilePage(),
                        type: PageTransitionType.rotate,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const AuthPage(),
                        type: PageTransitionType.rotate,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(22),
                    child: userStream.when(
                        data: (user) {
                          if (user.isNotEmpty) {
                            return Image.network(user.first.image ??
                                'https://firebasestorage.googleapis.com/v0/b/joecom-e54b3.appspot.com/o/generic%2Fno-user.jpg?alt=media&token=775706d1-b717-4bb5-9309-91b78d8f93a3');
                          } else {
                            return Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/joecom-e54b3.appspot.com/o/generic%2Fno-user.jpg?alt=media&token=775706d1-b717-4bb5-9309-91b78d8f93a3');
                          }
                        },
                        error: (e, trace) {
                          print(e.toString());
                          return const SizedBox();
                        }, //toast(context, e.toString()),
                        loading: () => const CircularProgressIndicator()),
                  ),
                ),
              ),
            ],
          );
        },
        error: (e, trace) {
          print(e.toString());
          return const SizedBox();
        }, //toast(context, e.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
