import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LocalityCard extends HookWidget {
  final String image;
  final String title;
  final String direction;
  final Function action;

  const LocalityCard({
    super.key,
    required this.image,
    required this.title,
    required this.direction,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final memoryImage = useMemoized(
        () => MemoryImage(Uint8List.fromList(base64.decode(image))), [image]);

    return GestureDetector(
      onTap: () {
        action();
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: memoryImage,
                width: 150,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    direction,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
