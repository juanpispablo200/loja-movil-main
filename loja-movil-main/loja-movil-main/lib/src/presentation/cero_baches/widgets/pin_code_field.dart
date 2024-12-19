import 'package:flutter/material.dart';
import 'package:loja_movil/constants.dart';

/// PinCodeField
class PinCodeField extends StatelessWidget {
  const PinCodeField({
    super.key,
    required this.pin,
    required this.pinCodeFieldIndex,
  });

  /// The pin code
  final String pin;

  /// The index of the pin code field
  final int pinCodeFieldIndex;

  Color get getFillColorFromIndex {
    if (pin.length > pinCodeFieldIndex) {
      return Colors.transparent;
    } else if (pin.length == pinCodeFieldIndex) {
      return const Color.fromARGB(255, 227, 231, 248);
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        height: 60,
        width: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: getFillColorFromIndex,
          borderRadius: const BorderRadius.all(
            Radius.circular(3),
          ),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: const Color(0XFFDCDCDC),
          ),
        ),
        duration: const Duration(microseconds: 4000),
        child: pin.length > pinCodeFieldIndex
            ? Text(
                pin[pinCodeFieldIndex],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kBlueColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 40,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
