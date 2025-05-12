import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final Color textColor;  // Color for text (required)
  final Color hintColor;  // Color for hint text (required)
  final Color iconColor;  // Color for icon (required)
  final Color borderColor;  // Color for the border (required)
  final Color fillColor;  // Color for the fill (required)
  final Color backgroundColor;  // Color for background (required)

  const CustomTextField({
    required this.hint,
    required this.icon,
    this.obscureText = false,
    required this.onChanged,
    required this.textColor,
    required this.hintColor,
    required this.iconColor,
    required this.borderColor,
    required this.fillColor,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;  // Initially uses the value from widget
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;  // Toggle the obscured state
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16,
      color: widget.textColor ?? Colors.black87,  // Use passed color or default
      fontFamily: 'NotoSansUI',
    );
    final hintStyle = TextStyle(color: widget.hintColor);  // Use passed color
    final iconColor = widget.iconColor;  // Use passed color
    final fillColor = widget.fillColor;  // Use passed color
    final backgroundColor = widget.backgroundColor;  // Use passed color
    final borderColor = widget.borderColor;  // Use passed color

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        obscureText: _isObscured,
        onChanged: widget.onChanged,
        style: textStyle,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: hintStyle,
          prefixIcon: Icon(widget.icon, color: iconColor),
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
            color: iconColor,
            onPressed: _togglePasswordVisibility,
          )
              : null,
          filled: true,
          fillColor: fillColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Adjust to desired radius
            borderSide: BorderSide(color: Colors.transparent, width: 0), // No visible border
          ),
          contentPadding: const EdgeInsets.all(18.0),
        ),
      ),
    );
  }
}
