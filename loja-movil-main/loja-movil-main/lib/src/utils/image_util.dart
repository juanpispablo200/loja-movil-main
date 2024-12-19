import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Uint8List getImageData(String image) {
  return Uint8List.fromList(base64.decode(image));
}

showGalleryImageModal(
  BuildContext context,
  String image,
) {
  showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      content: Builder(
        builder: (context) {
          return SizedBox(child: Image.memory(getImageData(image)));
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.close,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 40,
            ))
      ],
      actionsPadding: const EdgeInsets.all(0),
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.transparent,
    ),
  );
}
