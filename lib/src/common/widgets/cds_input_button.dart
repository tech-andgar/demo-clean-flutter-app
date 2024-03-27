import 'package:flutter/material.dart';

class CdsInputButton extends StatelessWidget {
  const CdsInputButton({
    required this.controller,
    required this.onPressed,
    super.key,
    this.hintText = 'https://',
  });

  final TextEditingController controller;
  final String hintText;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => Row(
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
