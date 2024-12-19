import 'package:flutter/material.dart';
import 'package:loja_movil/constants.dart';

class ServiceCard extends StatelessWidget {
  final Color backgroundColor;
  final Image iconImage;
  final String label;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.backgroundColor,
    required this.iconImage,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: iconImage,
              ),
            ),
            Text(
              label,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kGrayColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
