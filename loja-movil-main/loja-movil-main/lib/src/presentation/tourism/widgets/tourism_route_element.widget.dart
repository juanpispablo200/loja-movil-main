import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:loja_movil/constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TourismRouteElement extends HookWidget {
  final String image;
  final double size;
  final String name;
  final Function action;

  const TourismRouteElement({
    super.key,
    required this.image,
    required this.size,
    required this.name,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final memoryImage = useMemoized(
        () => MemoryImage(Uint8List.fromList(base64.decode(image))), [image]);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            action();
          },
          child: Stack(children: [
            Positioned(
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: memoryImage,
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: kPrimaryColor, width: 3),
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
