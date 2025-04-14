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
              backgroundImage: file != null
                  ? FileImage(file!)
                  : const NetworkImage(
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8fDA%3D"),
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

  void _onTabProfile(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const UpdatePrfile()));
  }
}
