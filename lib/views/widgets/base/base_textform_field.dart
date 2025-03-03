import 'package:flutter/material.dart';

class BaseTextformField extends StatefulWidget {
  final String label;
  final Function(String) setValue;
  final String? Function(String?)? validator;
  final bool? isMultiLine;
  final String? defaltParam;

  const BaseTextformField({
    super.key,
    required this.label,
    required this.setValue,
    this.validator,
    this.isMultiLine,
    this.defaltParam,
  });

  @override
  State<BaseTextformField> createState() => BaseTextformFieldState();
}

class BaseTextformFieldState extends State<BaseTextformField> {
  late TextEditingController controller = TextEditingController(text: widget.defaltParam ?? '');

  @override
  Widget build(BuildContext context) {
    final isMultiLine = widget.isMultiLine ?? false;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      color: Colors.white.withOpacity(0.5),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.label,
          border: InputBorder.none,
        ),
        onChanged: (value) => widget.setValue(value),
        keyboardType:
            isMultiLine ? TextInputType.multiline : TextInputType.text,
        maxLines: isMultiLine ? null : 1,
      ),
    );
  }
}
