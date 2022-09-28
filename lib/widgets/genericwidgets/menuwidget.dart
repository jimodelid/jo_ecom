import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/pages/AuthPage.dart';
import 'package:jo_ecom/pages/profilepage.dart';
import 'package:jo_ecom/services/providers/auth.dart';
import 'package:jo_ecom/widgets/genericwidgets/iconwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/toastwidget.dart';

class MenuWidget extends ConsumerWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const IconWidget(icon: EvaIcons.menu2Outline),
        GestureDetector(
          onTap: () {
            authState.when(
                data: (data) {
                  if (data != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthPage(),
                      ),
                    );
                  }
                },
                error: (e, trace) => toast(context, e.toString()),
                loading: () => const CircularProgressIndicator());
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(22),
              child: authState.when(
                data: (data) {
                  if (data != null) {
                    //DO: ADD USER PROFILE PICTURE INSTEAD OF STATIC IMAGE
                    return Image.network(
                      'https://ied.eu/wp-content/uploads/2018/04/entrepreneur-1.jpg',
                      fit: BoxFit.cover,
                    );
                  } else {
                    return Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/joecom-e54b3.appspot.com/o/generic%2Fno-user.jpg?alt=media&token=775706d1-b717-4bb5-9309-91b78d8f93a3',
                      fit: BoxFit.cover,
                    );
                  }
                },
                error: (e, trace) => toast(context, e.toString()),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
