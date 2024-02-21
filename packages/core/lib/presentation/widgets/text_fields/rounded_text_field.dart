import 'package:core/app/extensions/context.dart';
import 'package:core/presentation/widgets/text_fields/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator<String> validator;
  final Function(String) changed;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autoFocus;
  final VoidCallback? onEditingComplete;

  const RoundedTextField({
    required this.changed,
    required this.validator,
    required this.hintText,
    this.icon = Icons.person,
    required this.controller,
    required this.focusNode,
    this.autoFocus = false,
    required this.onEditingComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        onEditingComplete: onEditingComplete,
        autofocus: autoFocus,
        focusNode: focusNode,
        onChanged: changed,
        validator: validator,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: context.primaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
