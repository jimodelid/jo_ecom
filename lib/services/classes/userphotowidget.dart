import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jo_ecom/services/providers/firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jo_ecom/services/models/usermodel.dart';
import 'package:jo_ecom/widgets/genericwidgets/spacerwidget.dart';
import 'package:jo_ecom/widgets/genericwidgets/titlewidget.dart';

class UserPhoto extends ConsumerWidget {
  const UserPhoto({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const CenteredTitleWidget(
          title: 'Profile Photo',
          subtitle: 'Press the photo to change your profile picture',
        ),
        const VerticalSpacerWidget(height: 15),
        GestureDetector(
          onTap: () {
            selectFile(user, ref, context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(45),
              child: user.image != null
                  ? Image.network(
                      user.image!,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/joecom-e54b3.appspot.com/o/generic%2Fno-user.jpg?alt=media&token=775706d1-b717-4bb5-9309-91b78d8f93a3',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

Future selectFile(UserModel user, WidgetRef ref, BuildContext context) async {
  final ImagePicker result = ImagePicker();

  final XFile? image = await result.pickImage(
    source: ImageSource.gallery,
    imageQuality: 1,
    maxHeight: 512,
    maxWidth: 512,
  );

  if (image != null) {
    final file = File(image.path);

    if (file.path.isNotEmpty) {
      final destination = 'users/${user.id}/${user.id}';

      final upload = FirebaseStorage.instance.ref(destination);

      upload.putFile(file).then(
            (p0) => p0.ref.getDownloadURL().then(
              (value) {
                final newUser = UserModel(
                  id: user.id,
                  email: user.email,
                  createdAt: user.createdAt,
                  name: user.name,
                  address: user.address,
                  zip: user.zip,
                  area: user.area,
                  country: user.country,
                  image: value,
                  likes: user.likes,
                );

                ref.read(databaseProvider)!.updateUser(newUser, context);
              },
            ),
          );
    }
  }
}
