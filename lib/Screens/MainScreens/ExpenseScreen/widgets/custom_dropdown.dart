import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Constants/app_color.dart';
import '../../../../Services/LocalizationService.dart';

class CustomDropdown extends StatelessWidget {
  final List<Map<String, dynamic>> expenses;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    Key? key,
    required this.expenses,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalization = Provider.of<LocalizationService>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint:  Text(appLocalization.getLocalizedString("selectExpense")),
          isExpanded: true,
          items: expenses.map((item) {
            return DropdownMenuItem<String>(
              value: item['id'], // value passed in callback
              child: Text(item['name'] ?? ''),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
