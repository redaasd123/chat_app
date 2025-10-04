import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.onChanged,
    this.obscureText = false,
  });

  final String hintText;
  final Function(String)? onChanged;
  final bool obscureText;
  final IconData icon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText ? _isObscured : false,
      style: const TextStyle(color: Colors.black87, fontSize: 16),
      cursorColor: const Color(0xFF0A4D68),
      validator: (data) {
        if (data == null || data.trim().isEmpty) {
          return 'من فضلك أدخل هذا الحقل';
        }
        return null;
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: const Color(0xFF0A4D68)),
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        )
            : null,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFB0BEC5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF0A4D68), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
