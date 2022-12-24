import 'package:flutter/material.dart';

class TermsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onAdd;
  final Function onLogOut;

  const TermsAppBar(
      {super.key,
      required this.title,
      required this.onAdd,
      required this.onLogOut});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(onPressed: () => onLogOut(), icon: const Icon(Icons.logout)),
        IconButton(onPressed: () => onAdd(), icon: const Icon(Icons.add))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
