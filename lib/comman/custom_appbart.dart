import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;
  final String title;
  const CustomAppbar({
    super.key,
    this.color = Colors.white,
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      surfaceTintColor: color,
      title: title.isEmpty?null: Text(title),
      actions: [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
