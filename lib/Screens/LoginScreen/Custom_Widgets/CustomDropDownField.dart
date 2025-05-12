import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Services/LocalizationService.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final List<T> items;
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final String Function(T)? itemLabel;
  final bool isExpanded;
  final Color backgroundColor;
  final Color textColor;
  final Color hintColor;
  final Color borderColor;
  final Color arrowColor;


  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.hint,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.itemLabel,
    this.isExpanded = true,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.hintColor = Colors.grey,
    this.borderColor = Colors.grey,
    this.arrowColor =  const Color(0xFFF9AA33),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = items.isEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 8),
        Container(
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
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: selectedValue,
              isExpanded: isExpanded,
              // hint: Text(hint, style: TextStyle(color: hintColor)),
              hint: Text(
                isDisabled ? "No options available" : hint,
                style: TextStyle(color: hintColor),
              ),
              onChanged: onChanged,
              items: items.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(
                    itemLabel != null ? itemLabel!(value) : value.toString(),
                    style: TextStyle(color: textColor),
                  ),
                );
              }).toList(),
              iconEnabledColor: arrowColor,
              disabledHint: Text(
                Provider.of<LocalizationService>(context, listen: false).getLocalizedString("noDataAvailable"),//noDataAvailable
                style: TextStyle(color: hintColor,
                  fontSize: 14,  ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}