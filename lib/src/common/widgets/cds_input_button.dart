import 'package:flutter/material.dart';

class CdsInputButton extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onPressed;
  final String hintText;

  const CdsInputButton({
    super.key,
    required this.controller,
    required this.onPressed,
    this.hintText = 'https://',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        DecoratedBox(
          key: const Key('cds-input-button_button'),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[200]!,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 12,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.black),
              highlightColor: Colors.grey[200],
              onPressed: onPressed,
            ),
          ),
        ),
      ],
    );
  }
}
