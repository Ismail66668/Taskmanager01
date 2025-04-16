import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskmenager_app/screens/controller/authcontroller.dart';
import 'package:taskmenager_app/screens/login_screen.dart';
import 'package:taskmenager_app/screens/update_prfile.dart';

class TMAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppbar({super.key, this.fromProfileScren, this.file});
  final bool? fromProfileScren;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromProfileScren ?? false) {
            return;
          }
          _onTabProfile(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: _shouldShowImage(Authcontroller.userModel?.photo)
                  ? MemoryImage(
                      base64Decode(Authcontroller.userModel?.photo ?? ''),
                    )
                  : null,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Authcontroller.userModel?.fulName ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    Authcontroller.userModel?.email ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  _onTapLogOutButton(context);
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<void> _onTapLogOutButton(BuildContext context) async {
    await Authcontroller.clearUserData();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (predicate) => false);
  }

  bool _shouldShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }

  void _onTabProfile(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const UpdatePrfile()));
  }
}
