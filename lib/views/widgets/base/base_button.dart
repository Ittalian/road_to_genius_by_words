import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const BaseButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 20)));
  }
}
