import 'package:flutter/material.dart';
import 'package:loja_movil/constants.dart';

class EmptyData extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const EmptyData({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      Image.asset(
        'assets/images/empty_state.png',
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.25,
      ),
      Text(
        title,
        style: const TextStyle(color: kBlueColor, fontSize: 11),
      )
    ]));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
