import 'package:flutter/material.dart';
import 'package:loja_movil/constants.dart';
import 'package:loja_movil/src/utils/image_util.dart';

class CustomMarker extends StatelessWidget {
  final String image;

  const CustomMarker({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: MemoryImage(getImageData(image)),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: kPrimaryColor,
              width: 3.0,
            ),
          ),
        ),
      ],
    );
  }
}
