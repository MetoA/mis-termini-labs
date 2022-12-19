import 'package:flutter/material.dart';

class TermsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onAdd;

  const TermsAppBar({super.key, required this.title, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(onPressed: () => onAdd(), icon: const Icon(Icons.add))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
