import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';

class FiavAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const FiavAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: kFavPrimary,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: kFavSecondary,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: kFavPrimary,
          height: 4.0,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      leading: IconButton.filledTonal(
        padding: const EdgeInsets.only(right: 3.0),
        iconSize: 18.0,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kFavPrimary),
        ),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () => context.pop(), // Navigator.pop(context),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: kFavPrimary,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo_festival.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
