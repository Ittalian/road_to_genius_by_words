import 'package:flutter/material.dart';

class BaseTextButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final TextStyle? style;
  
  const BaseTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: style,
      ),
    );
  }
}
