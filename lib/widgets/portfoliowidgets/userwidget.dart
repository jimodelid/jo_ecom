import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/models/usermodel.dart';
import 'package:jo_ecom/services/providers/firebase.dart';
import 'package:jo_ecom/widgets/genericwidgets/spacerwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/titlewidget.dart';

class UserWidget extends ConsumerWidget {
  const UserWidget({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final zipController = TextEditingController();
    final areaController = TextEditingController();
    final countryController = TextEditingController();

    nameController.text = user.name ?? '';
    addressController.text = user.address ?? '';
    zipController.text = user.zip ?? '';
    areaController.text = user.area ?? '';
    countryController.text = user.country ?? '';

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CenteredTitleWidget(
              title: 'Easier Checkout',
              subtitle:
                  'By filling out this form you\'ll make your checkout experience faster for reccuring orders.'),
          const VerticalSpacerWidget(height: 20),
          TextFormField(
            controller: nameController,
            style: const TextStyle(
              fontSize: 14.0,
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
          const VerticalSpacerWidget(height: 15),
          TextFormField(
            controller: addressController,
            style: const TextStyle(
              fontSize: 14.0,
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
          const VerticalSpacerWidget(height: 15),
          Row(
            children: [
              SizedBox(
                width: width * 0.3,
                child: TextFormField(
                  controller: zipController,
                  style: const TextStyle(
                    fontSize: 14.0,
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
              const HorizontalSpacerWidget(width: 5),
              SizedBox(
                width: width * 0.58,
                child: TextFormField(
                  controller: areaController,
                  style: const TextStyle(
                    fontSize: 14.0,
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
          const VerticalSpacerWidget(height: 15),
          TextFormField(
            controller: countryController,
            style: const TextStyle(
              fontSize: 14.0,
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
          const VerticalSpacerWidget(height: 10),
          MaterialButton(
            minWidth: width * 0.6,
            height: 45,
            color: Colors.greenAccent,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final userInfo = UserModel(
                  id: user.id,
                  email: user.email,
                  createdAt: user.createdAt,
                  name: nameController.text,
                  address: addressController.text,
                  zip: zipController.text,
                  area: areaController.text,
                  country: countryController.text,
                  likes: user.likes,
                );

                ref.read(databaseProvider)!.updateUser(userInfo, context);

                /*ref.read(authenticationProvider).signUpWithEmailAndPassword(
                    user, passwordController.text, context, ref);*/
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
