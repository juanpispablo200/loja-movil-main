import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GifView.asset(
      'assets/animations/logo.gif',
      height: 90.0,
      width: 90.0,
      frameRate: 4, 
    );
  }
}
